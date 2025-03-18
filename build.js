import esbuild from 'esbuild'
import 'dotenv/config'
import { sassPlugin } from 'esbuild-sass-plugin'

const args = process.argv.slice(2)
const watch = args.includes('--watch')

const watchPlugin = {
    name: 'watch-plugin',
    setup(build) {
        build.onStart(() => { console.log(`Build starting: ${new Date(Date.now()).toLocaleString()}`) })
        build.onEnd((result) => {
            if (result.errors.length > 0) {
                console.log(`Build finished, with errors: ${new Date(Date.now()).toLocaleString()}`)
            } else {
                console.log(`Build finished successfully: ${new Date(Date.now()).toLocaleString()}`)
            }
        })
    }
}

let watchParam
if (watch) {
    watchParam =
        {
            onRebuild: (error, result) => {
                if (error) console.error('watch build failed: ', error)
                else console.log(`watch build succeeded: ${new Date}`, result)
            }
        }
} else {
    watchParam = false
}

const context = await esbuild.context({
    bundle: true,
    define: {
        'process.env.TEST_CHART_DEBUG_OUTPUT': process.env.TEST_CHART_DEBUG_OUTPUT || 'false'
    },
    entryPoints: ['app/javascript/admin.js', 'app/javascript/styles/admin_light.scss'],
    format: 'esm',
    outdir: 'app/assets/builds/triple_baked_core',
    plugins: [
        sassPlugin(),
        watchPlugin
    ],
    publicPath: '/assets',
    sourcemap: 'external',
})

if (watch) {
    await context.watch()
    console.log('watching...')
} else {
    context.rebuild()
    context.dispose()
}