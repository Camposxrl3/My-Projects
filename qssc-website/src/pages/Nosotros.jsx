export default function Nosotros() {
  return (
    <div className="max-w-5xl mx-auto px-5 py-8 space-y-10">

      {/* Hero Banner */}
      <div className="bg-[#BDD002] text-[#152B5E] text-center py-4 px-6 rounded-md shadow">
        <h1 className="text-xl md:text-2xl font-bold tracking-wide uppercase">
          Consultoría en Inocuidad y Calidad de Alimentos
        </h1>
      </div>

      {/* Quienes Somos + Logo Section */}
      <div className="bg-[#EAEAFA] border-b-4 border-[#152B5E] rounded-t-4xl p-4 shadow-sm gap-6 items-center">
        <div className="flex flex-col md:flex-row gap-6 items-center">
          {/* Left column */}
          <div className="flex-1">
            <h2 className="text-[#152B5E] font-bold text-2xl mb-3">
              ¿Quiénes Somos?
            </h2>
            <p className="text-gray-700 text-lg leading-relaxed">
              Somos un equipo de profesionales comprometidos, que brindamos asesoría especializada orientada a
              garantizar la calidad, la inocuidad y el cumplimiento de normas en empresas del sector
              alimentario. Trabajamos de la mano con nuestros clientes para optimizar sus procesos, fortalecer
              sus sistemas de control y asegurar que sus productos cumplan con los estándares regulatorios
              y de seguridad exigidos, contribuyendo así a la confianza del consumidor y al crecimiento
              sostenible de sus negocios.
            </p>
          </div>

          {/* Right column */}
          <div className="flex items-center justify-center md:w-100">
            <img src="./src/assets/bigLogo.svg" alt="QSS Logo" className="h-auto w-90" />
          </div>
        </div>
      </div>
      

      {/* Mission & Vision */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Misión */}
        <div className="bg-[#E1E9CE] rounded-3xl p-6 shadow-sm border-b-4 border-[#BDD002]">
          <h3 className="text-[#152B5E] font-bold text-center text-lg uppercase mb-3 tracking-wide">
            Misión
          </h3>
          <p className="text-gray-700 text-base text-center italic leading-relaxed">
            "Ser una empresa de consultoría que exceda los objetivos de los clientes, proporcionando
            valor agregado en sus productos y servicios"
          </p>
        </div>

        {/* Visión */}
        <div className="bg-[#E1E9CE] rounded-3xl p-6 shadow-sm border-b-4 border-[#BDD002]">
          <h3 className="text-[#152B5E] font-bold text-center text-lg uppercase mb-3 tracking-wide">
            Visión
          </h3>
          <p className="text-gray-700 text-base text-center italic leading-relaxed">
            "Ser una empresa líder en el mercado de la industria alimentaria que proporciones soluciones
            a las necesidades y requerimientos legales propios de la industria"
          </p>
        </div>
      </div>

    </div>
  );
}
