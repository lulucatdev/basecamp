<script setup lang="ts">
import { ref } from "vue"

const props = defineProps<{ count: number }>()

const localCount = ref(0)
</script>

<template>
  <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
    <div class="p-5 rounded-xl border border-indigo-200 bg-indigo-50/50">
      <p class="text-xs font-medium text-indigo-500 uppercase tracking-wide mb-1">Server State (LiveView)</p>
      <p class="text-4xl font-bold tabular-nums text-indigo-900 mb-4">{{ props.count }}</p>
      <div class="flex gap-2">
        <button
          phx-click="decrement"
          class="flex-1 px-3 py-1.5 rounded-lg text-sm font-semibold bg-indigo-200 text-indigo-800 hover:bg-indigo-300 transition"
        >
          -
        </button>
        <button
          phx-click="increment"
          class="flex-1 px-3 py-1.5 rounded-lg text-sm font-semibold bg-indigo-600 text-white hover:bg-indigo-700 transition"
        >
          +
        </button>
      </div>
    </div>
    <div class="p-5 rounded-xl border border-emerald-200 bg-emerald-50/50">
      <p class="text-xs font-medium text-emerald-500 uppercase tracking-wide mb-1">Client State (Vue)</p>
      <p class="text-4xl font-bold tabular-nums text-emerald-900 mb-4">{{ localCount }}</p>
      <div class="flex gap-2">
        <button
          @click="localCount--"
          class="flex-1 px-3 py-1.5 rounded-lg text-sm font-semibold bg-emerald-200 text-emerald-800 hover:bg-emerald-300 transition"
        >
          -
        </button>
        <button
          @click="localCount++"
          class="flex-1 px-3 py-1.5 rounded-lg text-sm font-semibold bg-emerald-600 text-white hover:bg-emerald-700 transition"
        >
          +
        </button>
      </div>
    </div>
  </div>
</template>
