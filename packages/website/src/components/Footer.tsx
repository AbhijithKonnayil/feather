export default function Footer() {
  return (
    <footer className="bg-gray-950 text-gray-300">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="flex flex-col md:flex-row items-center justify-between gap-6">
          <div className="flex items-center gap-3">
            <img src="/feather_brand.png" alt="Feather" className="h-8 w-8" />
            <span className="text-white font-semibold">Feather</span>
          </div>
          <div className="flex items-center gap-6">
            <a href="#docs" className="hover:text-white transition-colors">Docs</a>
            <a href="https://github.com/feather-ui/feather" target="_blank" rel="noopener noreferrer" className="hover:text-white transition-colors">GitHub</a>
            <a href="#community" className="hover:text-white transition-colors">Community</a>
          </div>
          <div className="text-sm text-gray-400">
            © 2025 Feather. Built with ❤️ by the open-source community.
          </div>
        </div>
      </div>
    </footer>
  )
}
