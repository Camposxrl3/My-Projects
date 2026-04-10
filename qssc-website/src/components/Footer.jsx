export default function Footer() {
  return (
    <footer className="bg-[#BDD002] py-4 mt-auto">
      <div className="max-w-5xl mx-auto px-6 flex items-center justify-center">
        <p className="text-[#152B5E] font-semibold text-center text-sm md:text-base">
          © {new Date().getFullYear()} Quality Systems Support Consultores. Todos los derechos reservados.
        </p>
      </div>
    </footer>
  );
}
