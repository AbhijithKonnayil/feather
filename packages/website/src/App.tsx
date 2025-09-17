import Hero from './components/Hero'
import Navbar from './components/Navbar'
import Features from './components/Features'
import Showcase from './components/Showcase'
import Community from './components/Community'
import Footer from './components/Footer'

// Docs Section Component
const DocsSection = () => {
  return (
    <section id="docs" className="py-20 bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
            Get Started in Minutes
          </h2>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">
            Follow our comprehensive documentation to integrate Feather into your Flutter project.
          </p>
        </div>
        
        <div className="bg-white rounded-xl p-8 shadow-sm max-w-4xl mx-auto">
          <div className="mb-6">
            <h3 className="text-xl font-semibold text-gray-900 mb-4">Installation</h3>
            <div className="bg-gray-900 rounded-lg p-4 text-green-400 font-mono text-sm">
              flutter pub add feather_ui
            </div>
          </div>
          
          <div className="mb-6">
            <h3 className="text-xl font-semibold text-gray-900 mb-4">Usage</h3>
            <div className="bg-gray-900 rounded-lg p-4 text-green-400 font-mono text-sm">
              <div>import 'package:feather_ui/feather_ui.dart';</div>
              <div className="mt-2">FeatherButton(</div>
              <div className="ml-4">text: 'Hello Feather!',</div>
              <div className="ml-4">onPressed: () =&gt; print('Pressed!'),</div>
              <div>)</div>
            </div>
          </div>
          
          <div className="text-center">
            <a 
              href="https://docs.featherui.dev" 
              target="_blank" 
              rel="noopener noreferrer"
              className="btn-primary"
            >
              View Full Documentation
            </a>
          </div>
        </div>
      </div>
    </section>
  )
}

// Main App Component
function App() {
  return (
    <div className="min-h-screen">
      <Navbar />
      <Hero />
      <Features />
      <Showcase />
      <Community />
      <DocsSection />
      <Footer />
    </div>
  )
}

export default App
