import { h, type Component } from "vue"
import { createLiveVue, findComponent, type LiveHook, type ComponentMap } from "live_vue"

declare module "vue" {
  interface ComponentCustomProperties {
    $live: LiveHook
  }
}

export default createLiveVue({
  resolve: (name) => {
    const components = {
      ...import.meta.glob("./**/*.vue", { eager: true }),
      ...import.meta.glob("../../lib/**/*.vue", { eager: true }),
    } as ComponentMap

    return findComponent(components as ComponentMap, name)
  },
  setup: ({ createApp, component, props, slots, plugin, el }) => {
    const app = createApp({ render: () => h(component as Component, props, slots) })
    app.use(plugin)
    app.mount(el)
    return app
  },
})
