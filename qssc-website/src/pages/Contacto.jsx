const contacts = [
  {
    name: 'Lcda. Gloribeth Jackeline Romero G.',
    phone: '6828-8540',
    email: 'gromero@qssconsultores.com',
  },
  {
    name: 'Ing. Carmen Natividad Pérez Díaz.',
    phone: '6864-4028',
    email: 'cperez@qssconsultores.com',
  },
  {
    name: 'Lcda. Yomallys Angelis Palacios Olivanes.',
    phone: null,
    email: 'ypalacios@qssconsultores.com',
  },
];

function PhoneIcon() {
  return (
    <img src="./src/assets/Iconos/telefono.png" alt="Telefono" className="w-6 h-6 mr-3" />
  );
}

function EmailIcon() {
  return (
    <img src="./src/assets/Iconos/correo.png" alt="Correo Electrónico" className="w-6 h-6 mr-3" />
  );
}

export default function Contacto() {
  return (
    <div className="max-w-4xl mx-auto px-6 py-10 space-y-10">

      {/* Title */}
      <h1 className="text-[#152B5E] font-bold text-2xl text-center uppercase tracking-wide">
        Contacto
      </h1>

      {/* Contact Card */}
      <div className="border-b-4 border-[#152B5E] rounded-t-4xl p-8 bg-[#EAEAFA] shadow-md">
        <div className="flex flex-col md:flex-row items-center gap-8">

          {/* Illustration */}
          <div className="flex items-center justify-center md:w-100">
              <img src="./src/assets/Iconos/contacto.png" alt="Contacto" className="h-85 w-85" />

          </div>

          {/* Contact List */}
          <div className="flex-1 space-y-6 divide-y divide-gray-200">
            {contacts.map(({ name, phone, email }) => (
              <div key={email} className="pt-4 first:pt-0">
                <p className="text-[#152B5E] font-semibold text-lg mb-1">{name}</p>
                {phone && (
                  <p className="text-gray-600 text-base flex items-center">
                    <PhoneIcon />
                    {phone}
                  </p>
                )}
                <p className="text-gray-600 text-base flex items-center mt-1">
                  <EmailIcon />
                  <a
                    href={`mailto:${email}`}
                    className="text-[#152B5E] hover:underline break-all"
                  >
                    {email}
                  </a>
                </p>
              </div>
            ))}
          </div>

        </div>
      </div>

      {/* Quote Banner */}
      <div className="bg-[#152B5E] text-white text-center py-5 px-6 rounded-md shadow">
        <p style={{fontFamily: '"Great Vibes", cursive' }} className="text-4xl">
          "Calidad que genera confianza y resultados"
        </p>
      </div>

    </div>
  );
}
