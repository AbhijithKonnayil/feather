# Feather Website

Official Feather website (landing + docs).

- Tech: React 19 + TypeScript + Vite
- Package manager: Yarn

## Prerequisites

- Node.js 18+
- Yarn

## Install

```sh
yarn install
```

## Develop

```sh
yarn dev
```

Vite will start a local dev server and print the URL.

## Build

```sh
yarn build
```

Static files are output to `dist/`.

## Preview (serve production build)

```sh
yarn preview
```

## Project Structure

```text
packages/website/
├── public/            # Static assets
├── src/               # Application source (React + TS)
├── index.html         # Vite HTML entry
├── vite.config.ts     # Vite configuration (React plugin)
├── package.json       # Scripts and dependencies
└── tsconfig*.json     # TypeScript configs
```

## Links

- Root Repository: [github.com/AbhijithKonnayil/feather](https://github.com/AbhijithKonnayil/feather)
