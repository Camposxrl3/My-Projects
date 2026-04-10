import { Link, useLocation } from 'react-router-dom';

export default function Navbar() {
  const location = useLocation();

  const links = [
    { label: 'Nosotros', to: '/nosotros' },
    { label: 'Servicios', to: '/servicios' },
    { label: 'Contacto', to: '/contacto' },
  ];

  return (
    <header className="bg-[#152B5E] shadow-md sticky top-0 z-50">
      <div className="max-w-5xl mx-auto py-2 flex items-center justify-between">
        {/* Logo + Brand */}
        <Link to="/" className="flex items-center gap-3 group">
          <img src="./src/assets/logo.svg" alt="QSS Logo" className="h-18 w-auto px-3" />
          <div className="leading-tight">
            <h1 className="text-white font-bold italic md:text-2xl">Quality Systems</h1>
            <h1 className="text-white font-bold italic md:text-2xl">Support Consultores</h1>
          </div>
        </Link>

        {/* Nav Links */}
        <nav className="flex items-center gap-1">
          {links.map(({ label, to }) => {
            const isActive = location.pathname === to || (to === '/nosotros' && location.pathname === '/');
            return (
              <Link
                key={to}
                to={to}
                className={`px-4 py-2 rounded md:text-lg font-semibold transition-all duration-200
                  ${isActive
                    ? 'underline underline-offset-6 text-white'
                    : 'text-white hover:bg-[#152B5E]/10'
                  }`}
              >
                {label}
              </Link>
            );
          })}
        </nav>
      </div>
    </header>
  );
}
