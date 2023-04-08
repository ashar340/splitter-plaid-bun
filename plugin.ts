import Elysia from "elysia"

export const loadStatic = async (app: Elysia) => {
    const files = await loadAllFiles()

    files.forEach((file) => app
        .get(file, () => Bun.file(file))
    )

    return app
}