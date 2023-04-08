import { Elysia, ws } from 'elysia'
// import { loadStatic } from './plugin'

const app = new Elysia()
// .use(loadStatic)
    .use(ws({
        perMessageDeflate: true,
        
    }))
    .ws('/ws', {
        message(ws, message) {
            ws.send(message)
        }
    })
    .listen(8080)

console.log(`🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`)

