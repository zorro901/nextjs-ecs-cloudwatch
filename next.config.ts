import type { NextConfig } from 'next'

const nextConfig: NextConfig = {
    output: 'standalone',
    reactStrictMode: true,
    poweredByHeader: false, // X-Powered-By ヘッダーを無効化
    generateBuildId: () => {
        const env = process.env.NODE_ENV
        const version = process.env.npm_package_version ?? '0.0.0'
        // ビルド番号などの環境変数があれば使用
        const buildNumber = process.env.BUILD_NUMBER ?? ''
        return [version, env, buildNumber].filter(Boolean).join('-')
    }
}

export default nextConfig
