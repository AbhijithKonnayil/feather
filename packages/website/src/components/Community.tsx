import { useEffect, useState } from 'react'

export default function Community() {
  const [stars, setStars] = useState<number | null>(null)
  const [contributors, setContributors] = useState<number | null>(null)

  useEffect(() => {
    const repo = 'feather-ui/feather'
    fetch(`https://api.github.com/repos/${repo}`)
      .then(r => r.ok ? r.json() : Promise.reject(r))
      .then(data => setStars(data?.stargazers_count ?? null))
      .catch(() => setStars(null))

    fetch(`https://api.github.com/repos/${repo}/contributors?per_page=100&anon=true`)
      .then(r => r.ok ? r.json() : Promise.reject(r))
      .then(list => setContributors(Array.isArray(list) ? list.length : null))
      .catch(() => setContributors(null))
  }, [])

  return (
    <section id="community" className="py-20 bg-white" aria-labelledby="community-heading">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center max-w-2xl mx-auto">
          <h2 id="community-heading" className="text-3xl sm:text-4xl font-bold text-gray-900">Join the Community</h2>
          <p className="mt-4 text-gray-600">Be part of a growing open-source ecosystem building beautiful Flutter apps with Feather.</p>
        </div>

        <div className="mt-12 grid grid-cols-1 sm:grid-cols-3 gap-6">
          <div className="rounded-2xl border border-gray-100 bg-white p-6 text-center shadow-sm">
            <div className="text-4xl font-bold text-blue-600">{stars !== null ? stars.toLocaleString() : '—'}</div>
            <div className="mt-1 text-gray-600">GitHub Stars</div>
          </div>
          <div className="rounded-2xl border border-gray-100 bg-white p-6 text-center shadow-sm">
            <div className="text-4xl font-bold text-blue-600">{contributors !== null ? `${contributors}+` : '—'}</div>
            <div className="mt-1 text-gray-600">Contributors</div>
          </div>
          <div className="rounded-2xl border border-gray-100 bg-white p-6 text-center shadow-sm">
            <div className="text-4xl font-bold text-blue-600">10k+</div>
            <div className="mt-1 text-gray-600">Downloads</div>
          </div>
        </div>

        <div className="mt-10 text-center">
          <a
            href="https://github.com/feather-ui/feather/discussions"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center rounded-lg border border-cyan-500 px-6 py-3 font-semibold text-cyan-600 transition-all hover:bg-gradient-to-r hover:from-cyan-500 hover:to-blue-600 hover:text-white"
          >
            Join the Community
          </a>
        </div>
      </div>
    </section>
  )
}
