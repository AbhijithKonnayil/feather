import { useState } from 'react'

export default function Navbar() {
  const [open, setOpen] = useState(false)

  const scrollTo = (id: string) => {
    const el = document.getElementById(id)
    el?.scrollIntoView({ behavior: 'smooth' })
    setOpen(false)
  }

  return (
    <header className="sticky top-0 z-50 border-b border-white/60 bg-white/80 backdrop-blur supports-[backdrop-filter]:bg-white/70">
      <nav className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        {/* Brand */}
        <a href="#" className="flex items-center gap-3">
          <img src="/feather_brand.png" alt="Feather" className="h-8 w-8" />
          <span className="font-bold text-gray-900">Feather</span>
        </a>

        {/* Desktop links */}
        <div className="hidden md:flex items-center gap-8">
          <button onClick={() => scrollTo('docs')} className="text-sm text-gray-600 hover:text-gray-900 transition-colors">Docs</button>
          <button onClick={() => scrollTo('showcase')} className="text-sm text-gray-600 hover:text-gray-900 transition-colors">Components</button>
          <a href="https://github.com/feather-ui/feather" target="_blank" rel="noopener noreferrer" className="text-sm text-gray-600 hover:text-gray-900 transition-colors">GitHub</a>
          <button onClick={() => scrollTo('community')} className="text-sm text-gray-600 hover:text-gray-900 transition-colors">Community</button>
          <button onClick={() => scrollTo('docs')} className="hidden lg:inline-flex items-center rounded-lg bg-gradient-to-r from-cyan-500 to-blue-600 px-4 py-2 text-sm font-semibold text-white shadow-sm transition-transform hover:shadow-lg hover:scale-[1.03]">Get Started</button>
        </div>

        {/* Mobile toggle */}
        <button onClick={() => setOpen(v => !v)} className="md:hidden p-2 text-gray-600 hover:text-gray-900">
          <svg className="h-6 w-6" viewBox="0 0 24 24" fill="none" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h16"/></svg>
        </button>
      </nav>

      {/* Mobile menu */}
      {open && (
        <div className="md:hidden border-t border-gray-100 bg-white/90 backdrop-blur">
          <div className="px-4 py-3 space-y-2">
            <button onClick={() => scrollTo('docs')} className="block w-full text-left px-2 py-2 rounded hover:bg-gray-50">Docs</button>
            <button onClick={() => scrollTo('showcase')} className="block w-full text-left px-2 py-2 rounded hover:bg-gray-50">Components</button>
            <a href="https://github.com/feather-ui/feather" target="_blank" rel="noopener noreferrer" className="block w-full text-left px-2 py-2 rounded hover:bg-gray-50">GitHub</a>
            <button onClick={() => scrollTo('community')} className="block w-full text-left px-2 py-2 rounded hover:bg-gray-50">Community</button>
            <button onClick={() => scrollTo('docs')} className="mt-2 inline-flex items-center rounded-lg bg-gradient-to-r from-cyan-500 to-blue-600 px-4 py-2 text-sm font-semibold text-white shadow-sm">Get Started</button>
          </div>
        </div>
      )}
    </header>
  )
}
