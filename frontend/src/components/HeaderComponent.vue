<template>
  <q-header reveal class="bg-transparent text-black " height-hint="98" >
    <q-toolbar>
      <q-btn  flat dense rounded label="Категории" no-caps style="font-weight: bold"></q-btn>
      <q-btn  flat dense rounded label="О нас" no-caps class="q-ml-lg" style="font-weight: bold"></q-btn>
      <q-toolbar-title>
        <router-link to="/">
          <a class="row absolute-center text-grey-10 text-h6 text-weight-bold  ">=＾• ⋏ •＾=</a>
        </router-link>
      </q-toolbar-title>
<!--      <Transition>-->
<!--        <q-input v-if="liked" dense outlined rounded color="dark" v-model="email" label="Поиск..." style="width: 220px"><template v-slot:prepend></template></q-input>-->
<!--      </Transition>-->
<!--      <q-btn dense flat round icon="search" @click="liked = !liked" class="q-ml-xs q-mr-lg">{{ liked ? '' : '' }}</q-btn>-->
      <q-btn flat rounded dense icon="shopping_bag" label="(0)" no-caps class="q-mr-lg" style="font-weight: bold"></q-btn>
      <router-link v-if="store.state.authenticated" to="/account" style="color: #1D1D1D">
      <q-btn flat rounded dense icon="account_circle" no-caps style="font-weight: bold"></q-btn>
      </router-link>
       <router-link v-else to="/login" style="color: #1D1D1D">
      <q-btn flat rounded dense icon="account_circle" no-caps style="font-weight: bold"></q-btn>
      </router-link>
    </q-toolbar>
    <q-separator class="absolute-center" style="width: 2000px; margin-top:28px; color: #f5f5f5"></q-separator>
  </q-header>
</template>

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>

<script setup>
  import { ref } from 'vue'
  import store from "src/store";

  const liked = ref(true)
</script>
