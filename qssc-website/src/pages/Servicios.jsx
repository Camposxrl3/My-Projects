const services = [
  {
    icon: (
      <img src="./src/assets/Iconos/documentos.png" alt="Consultoría" className="w-15 h-15" />
    ),
    text: 'Confección, revisión y mantenimiento de Manuales de Calidad, Buenas Prácticas de Manufactura (BPM), Procedimiento Operativo Estandarizado de Sanitación (SSOP), Análisis de Peligro y Puntos Críticos de Control (HACCP).',
  },
  {
    icon: (
      <img src="./src/assets/Iconos/capacitacion.png" alt="Capacitación" className="w-15 h-15" />
    ),
    text: 'Ofrecemos servicios de capacitación dirigido al personal operativo y administrativo, enfocado en el cumplimiento de normas de calidad e inocuidad alimentaria, fortaleciendo sus competencias.',
  },
  {
    icon: (
      <img src="./src/assets/Iconos/licencias.png" alt="Renovación" className="w-15 h-15" />
    ),
    text: 'Trámites o renovación de Licencia de Operación Sanitaria a través del DINACAVV (Dirección Nacional de Control de Alimentos y Vigilancia Veterinaria).',
  },
  {
    icon: (
      <img src="./src/assets/Iconos/iso.png" alt="ISO" className="w-15 h-15" />
    ),
    text: 'Seguimiento de Sistema Gestión de Calidad bajo el criterio de la Norma ISO 9001:2015.',
  },
];

const audiences = [
  { label: 'Restaurantes', icon: <img src="./src/assets/Iconos/restaurante.png" alt="Restaurantes" className="w-13 h-13" /> },
  { label: 'Supermercados', icon: <img src="./src/assets/Iconos/supermercado.png" alt="Supermercados" className="w-13 h-13" /> },
  { label: 'Emprendedores', icon: <img src="./src/assets/Iconos/emprendedor.png" alt="Emprendedores" className="w-13 h-13" /> },
  { label: 'Procesadoras de alimentos', icon: <img src="./src/assets/Iconos/industria.png" alt="Procesadoras de alimentos" className="w-13 h-13" /> },
];

export default function Servicios() {
  return (
    <div className="max-w-5xl mx-auto px-5 py-8 space-y-8">

      {/* Title */}
      <h1 className="text-[#152B5E] font-bold text-2xl text-center uppercase tracking-wide">
        Nuestros Servicios
      </h1>

      {/* Services Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {services.map((service, idx) => (
          <div
            key={idx}
            className="bg-[#EAEAFA] rounded-3xl p-5 shadow-sm flex flex-col items-center text-center gap-4 hover:shadow-md transition-shadow duration-200"
          >
            <div>
              {service.icon}
            </div>
            <p className="text-gray-700 text-base leading-relaxed">{service.text}</p>
          </div>
        ))}
      </div>

      {/* Directed To */}
      <div>
        <h2 className="text-[#152B5E] font-bold text-xl text-center uppercase tracking-wide mb-6">
          Dirigidos A
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {audiences.map(({ label, icon }) => (
            <div
              key={label}
              className="bg-[#E1E9CE] rounded-3xl p-5 flex flex-col items-center gap-2 shadow-sm hover:shadow-md transition-shadow duration-200"
            >
              <span className="text-3xl">{icon}</span>
              <p className="text-[#152B5E] font-semibold text-sm text-center">{label}</p>
            </div>
          ))}
        </div>
      </div>

    </div>
  );
}
