import Fastify from 'fastify';
import Stripe from 'stripe';
import cors from '@fastify/cors';
import FastifyStatic from '@fastify/static';
import {connect} from './DB/db.js';
import {Users} from './DB/models.js';
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';
dotenv.config();

const PORT = process.env.PORT;
const MONGO_URI = process.env.MONGO_URI;

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);
const fastify = Fastify({
    logger: true,
}); 

fastify.register(FastifyStatic, {
  root: path.join(dirname(fileURLToPath(import.meta.url)), 'Frontend'),
  prefix: '/',
})

fastify.register(cors, {
    origin: "*", // Permite de donde recibe los request del front (en este caso permite de cualquier lugar)
    methods: ['GET', 'POST', 'PUT', 'DELETE'], //Metodos permitidos
    allowedHeaders: ['Content-Type'], // Permite headers con Content-Type
});

fastify.get('/success', async (request, reply) => {
    try{
        const { session_id, monedas, correo } = request.query;
        const session = await stripe.checkout.sessions.retrieve(session_id);
        const monedasCompradas = parseInt(monedas);

        const update = await Users.findOneAndUpdate(
        { correo },
        { $inc: { monedas: monedasCompradas } },
        { new: true }
        );

        if(!update){
            return reply.status(404).send({mensaje: 'Correo no encontrado'});
        }
        console.log("Usuario Actualizado");
        console.log({ session });
        return reply.sendFile('success.html');
    }catch (err){
        return reply.status(500).send({mensaje: 'Error interno del servidor', error: err.message});
    }
    
});

fastify.get('/canceled', (request, reply) => {
    return reply.sendFile('cancel.html');
});

fastify.get('/api/v1/login/:email', async (request, reply) => {
   try{
        const user = await Users.findOne({correo: request.params.email});
        if(!user){
            return {mensaje: 'Correo no encontrado'};
        }
        return user;
    }catch (err){
        return reply.status(500).send({mensaje: 'Error interno del servidor', error: err.message});
    }
});

fastify.post('/api/v1/signup', async (request, reply) => {
    try{
        const user = await Users.create(request.body);
        return reply.status(200).send({mensaje: 'Usuario registrado'});
    }catch (err){
        return reply.status(500).send({mensaje: 'Error interno del servidor', error: err.message});
    }
    
});

fastify.post('/api/v1/create-checkout-session', async (request, reply) => {
  try {
    const { monedas, price , correo} = request.body;

    const session = await stripe.checkout.sessions.create({
      mode: 'payment',
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'usd',
            unit_amount: price * 100,
            product_data: {
              name: `${monedas} Monedas`,
            },
          },
          quantity: 1,
        },
      ],
      success_url: `http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}&monedas=${monedas}&correo=${correo}`,
      cancel_url: "http://localhost:3000/canceled?session_id={CHECKOUT_SESSION_ID}",
    });

    return {
      url: session.url
    }
  } catch (error) {
    console.error('Error creating checkout session:', error);
    reply.status(500).send({ error: 'Failed to create checkout session' });
  }
});

const start = async () => {
    try{
        await connect(MONGO_URI);
        console.log("conectado a mongoDB")
        await fastify.listen({ port: PORT});
    }catch (err){
        fastify.log.error(err);
        process.exit(1);
    }
};

start();