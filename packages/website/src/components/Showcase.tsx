export default function Showcase() {
  const items = [
    { name: 'Buttons', desc: 'Variants, sizes, icons', color: 'from-cyan-500 to-blue-600' },
    { name: 'Cards', desc: 'Surface, elevation, media', color: 'from-fuchsia-500 to-purple-600' },
    { name: 'Forms', desc: 'Inputs, selects, toggles', color: 'from-emerald-500 to-teal-600' },
    { name: 'Navigation', desc: 'Tabs, sidebars, app bars', color: 'from-amber-500 to-orange-600' },
    { name: 'Modals', desc: 'Dialogs, sheets, toasts', color: 'from-rose-500 to-pink-600' },
    { name: 'Charts', desc: 'Spark, bars, lines', color: 'from-indigo-500 to-blue-700' },
  ]

  return (
    <section id="showcase" className="py-20 bg-gray-50" aria-labelledby="showcase-heading">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center max-w-2xl mx-auto">
          <h2 id="showcase-heading" className="text-3xl sm:text-4xl font-bold text-gray-900">Component Showcase</h2>
          <p className="mt-4 text-gray-600">Explore a selection of components designed for speed and polish.</p>
        </div>

        <div className="mt-12 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {items.map((it, i) => (
            <div key={i} className="rounded-2xl border border-gray-100 bg-white p-6 shadow-sm transition-all hover:-translate-y-1 hover:shadow-lg">
              <div className={`h-32 rounded-xl bg-gradient-to-r ${it.color} flex items-center justify-center text-white font-semibold`}>{it.name}</div>
              <h3 className="mt-4 text-lg font-semibold text-gray-900">{it.name}</h3>
              <p className="mt-1 text-gray-600">{it.desc}</p>
              <button className="mt-4 text-blue-600 font-medium hover:text-blue-700">View Component →</button>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
