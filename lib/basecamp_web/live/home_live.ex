defmodule BasecampWeb.HomeLive do
  use BasecampWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  @impl true
  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  @impl true
  def handle_event("decrement", _params, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="max-w-2xl mx-auto py-16">
        <%!-- Hero --%>
        <div class="text-center mb-16">
          <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-indigo-50 text-indigo-700 text-xs font-medium mb-6">
            Phoenix + LiveVue Starter Template
          </div>
          <h1 class="text-5xl font-bold tracking-tight text-gray-900 mb-4">Basecamp</h1>
          <p class="text-lg text-gray-500 max-w-md mx-auto">
            Ship fullstack apps with Phoenix LiveView and Vue.js components. Everything wired up and ready to go.
          </p>
        </div>

        <%!-- Tech Stack --%>
        <div class="flex flex-wrap justify-center gap-2 mb-16">
          <span class="px-3 py-1 rounded-full text-xs font-medium bg-orange-50 text-orange-600 ring-1 ring-orange-200">Phoenix 1.8</span>
          <span class="px-3 py-1 rounded-full text-xs font-medium bg-green-50 text-green-600 ring-1 ring-green-200">LiveVue</span>
          <span class="px-3 py-1 rounded-full text-xs font-medium bg-emerald-50 text-emerald-600 ring-1 ring-emerald-200">Vue 3</span>
          <span class="px-3 py-1 rounded-full text-xs font-medium bg-purple-50 text-purple-600 ring-1 ring-purple-200">Vite</span>
          <span class="px-3 py-1 rounded-full text-xs font-medium bg-sky-50 text-sky-600 ring-1 ring-sky-200">Tailwind v4</span>
          <span class="px-3 py-1 rounded-full text-xs font-medium bg-blue-50 text-blue-600 ring-1 ring-blue-200">Postgres</span>
        </div>

        <%!-- LiveVue Demo --%>
        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm overflow-hidden mb-8">
          <div class="px-6 pt-6 pb-2">
            <h2 class="text-sm font-semibold text-gray-900">LiveVue is working</h2>
            <p class="text-sm text-gray-500 mt-1">
              Left: server state via LiveView (<code class="text-xs bg-gray-100 px-1 py-0.5 rounded">phx-click</code>).
              Right: client state via Vue (<code class="text-xs bg-gray-100 px-1 py-0.5 rounded">@click</code>).
            </p>
          </div>
          <div class="p-6">
            <.vue v-component="Counter" v-socket={@socket} count={@count} />
          </div>
        </div>

        <%!-- Quick Start --%>
        <div class="rounded-2xl border border-gray-200 bg-gray-50/50 overflow-hidden mb-8">
          <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-sm font-semibold text-gray-900">Quick Start</h2>
          </div>
          <div class="px-6 py-4 font-mono text-sm text-gray-700 leading-relaxed space-y-1">
            <div>mix setup          <span class="text-gray-400"># deps, db, migrations, assets</span></div>
            <div>make run-dev       <span class="text-gray-400"># start dev server</span></div>
          </div>
          <div class="px-6 py-3 bg-amber-50 border-t border-amber-100">
            <p class="text-xs text-amber-700">
              Requires PostgreSQL running locally. Connection settings in <code class="bg-amber-100/50 px-1 py-0.5 rounded">config/dev.exs</code>.
            </p>
          </div>
        </div>

        <%!-- Next Steps --%>
        <div class="rounded-2xl border border-gray-200 bg-gray-50/50 overflow-hidden">
          <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-sm font-semibold text-gray-900">Next Steps</h2>
          </div>
          <ul class="divide-y divide-gray-100">
            <li class="flex items-start gap-3 px-6 py-3">
              <span class="mt-0.5 size-5 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center text-xs font-bold shrink-0">1</span>
              <span class="text-sm text-gray-600">Replace this page &mdash; <code class="text-xs bg-gray-200 px-1.5 py-0.5 rounded">lib/basecamp_web/live/home_live.ex</code></span>
            </li>
            <li class="flex items-start gap-3 px-6 py-3">
              <span class="mt-0.5 size-5 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center text-xs font-bold shrink-0">2</span>
              <span class="text-sm text-gray-600">Update the header &mdash; <code class="text-xs bg-gray-200 px-1.5 py-0.5 rounded">lib/basecamp_web/components/layouts.ex</code></span>
            </li>
            <li class="flex items-start gap-3 px-6 py-3">
              <span class="mt-0.5 size-5 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center text-xs font-bold shrink-0">3</span>
              <span class="text-sm text-gray-600">Add routes &mdash; <code class="text-xs bg-gray-200 px-1.5 py-0.5 rounded">lib/basecamp_web/router.ex</code></span>
            </li>
            <li class="flex items-start gap-3 px-6 py-3">
              <span class="mt-0.5 size-5 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center text-xs font-bold shrink-0">4</span>
              <span class="text-sm text-gray-600">Generate schemas &mdash; <code class="text-xs bg-gray-200 px-1.5 py-0.5 rounded">mix phx.gen.schema</code></span>
            </li>
            <li class="flex items-start gap-3 px-6 py-3">
              <span class="mt-0.5 size-5 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center text-xs font-bold shrink-0">5</span>
              <span class="text-sm text-gray-600">Add Vue components &mdash; <code class="text-xs bg-gray-200 px-1.5 py-0.5 rounded">assets/vue/</code></span>
            </li>
          </ul>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
