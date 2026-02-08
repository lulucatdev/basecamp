import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import liveVuePlugin from "live_vue/vitePlugin";
import tailwindcss from "@tailwindcss/vite";
import { phoenixVitePlugin } from "phoenix_vite";

export default defineConfig(({ command }) => {
  const isDev = command !== "build";

  return {
    publicDir: false,
    plugins: [
      vue({
        template: {
          transformAssetUrls: false,
        },
      }),
      liveVuePlugin(),
      tailwindcss(),
      phoenixVitePlugin(),
    ],
    resolve: {
      alias: {
        "@": __dirname,
      },
      dedupe: ["vue"],
    },
    optimizeDeps: {
      include: ["live_vue", "phoenix", "phoenix_html", "phoenix_live_view"],
    },
    ssr: {
      noExternal: isDev ? undefined : true,
    },
    server: {
      host: "127.0.0.1",
      port: 5175,
      strictPort: true,
      cors: {
        origin: "http://localhost:4002",
      },
    },
    build: {
      outDir: "../priv/static",
      emptyOutDir: false,
      manifest: false,
      ssrManifest: false,
      rollupOptions: {
        input: {
          app: "js/app.js",
          "app-css": "css/app.css",
        },
        output: {
          entryFileNames: "assets/[name].js",
          chunkFileNames: "assets/[name]-[hash].js",
          assetFileNames: "assets/[name][extname]",
        },
      },
    },
  };
});
