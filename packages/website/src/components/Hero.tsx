export default function Hero() {
  return (
    <section className="relative bg-gradient-to-b from-blue-50 to-white">
      <div className="container mx-auto px-6 lg:px-20 py-20 grid grid-cols-1 lg:grid-cols-2 items-center gap-12">
        {/* Left Content */}
        <div className="text-center lg:text-left">
          <h1 className="text-4xl sm:text-5xl font-bold leading-tight bg-gradient-to-r from-cyan-500 to-blue-600 bg-clip-text text-transparent animate-fade-in">
            Build beautiful apps faster with Feather
          </h1>

          <p className="mt-6 text-lg text-gray-600 max-w-xl mx-auto lg:mx-0 animate-fade-in delay-150">
            Feather is an open-source Flutter component library designed to help
            you build elegant apps quickly. With prebuilt widgets, full
            customization, and performance in mind — Feather makes your
            development experience smooth and enjoyable.
          </p>

          <div className="mt-8 flex flex-col sm:flex-row gap-4 justify-center lg:justify-start animate-fade-in delay-300">
            <a
              href="#docs"
              className="px-6 py-3 rounded-lg text-white font-medium shadow-md bg-gradient-to-r from-cyan-500 to-blue-600 hover:scale-105 hover:shadow-lg transition-transform duration-200"
            >
              Get Started
            </a>
            <a
              href="https://github.com/AbhijithKonnayil/feather"
              target="_blank"
              rel="noopener noreferrer"
              className="px-6 py-3 rounded-lg font-medium border border-cyan-500 text-cyan-600 hover:bg-gradient-to-r hover:from-cyan-500 hover:to-blue-600 hover:text-white transition-all duration-200"
            >
              View on GitHub
            </a>
          </div>
        </div>

        {/* Right Content */}
        <div className="flex justify-center lg:justify-end">
          <img
            src="/feather_logo.png"
            alt="Feather Logo"
            className="w-72 lg:w-96 animate-float"
          />
        </div>
      </div>

      {/* Decorative blurred shapes */}
      <div className="absolute top-0 left-0 w-72 h-72 bg-cyan-100 rounded-full mix-blend-multiply filter blur-3xl opacity-40 animate-blob"></div>
      <div className="absolute bottom-10 right-0 w-72 h-72 bg-blue-200 rounded-full mix-blend-multiply filter blur-3xl opacity-40 animate-blob animation-delay-2000"></div>
    </section>
  );
}

