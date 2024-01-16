<template>
  <q-header class="bg-white text-black" style="height: 50px" >
    <q-toolbar>
      <router-link to="/categories">
        <q-btn  flat dense rounded label="Категории" no-caps style="font-weight: bold; margin-left: 15px; width: 88px"></q-btn>
      </router-link>
      <router-link to="/about">
        <q-btn  flat dense rounded label="О нас" no-caps class="q-ml-lg" style="font-weight: bold; width: 50px"></q-btn>
      </router-link>
      <q-toolbar-title>
        <router-link to="/">
          <a class="row absolute-center text-grey-10 text-h6 text-weight-bold  ">=＾• ⋏ •＾=</a>
        </router-link>
      </q-toolbar-title>
<!--      <Transition>-->
<!--        <q-input v-if="liked" dense outlined rounded color="dark" v-model="email" label="Поиск..." style="width: 220px"><template v-slot:prepend></template></q-input>-->
<!--      </Transition>-->
<!--      <q-btn dense flat round icon="search" @click="liked = !liked" class="q-ml-xs q-mr-lg">{{ liked ? '' : '' }}</q-btn>-->
      <router-link to="/bucket">
        <q-btn flat rounded dense icon="shopping_bag" label="(0)" no-caps class="q-mr-lg" style="font-weight: bold"></q-btn>
      </router-link>
      <router-link v-if="store.state.authenticated" to="/account" style="color: #1D1D1D">
      <q-btn flat rounded dense icon="account_circle" no-caps style="font-weight: bold; margin-right: 15px"></q-btn>
      </router-link>
       <router-link v-else to="/login" style="color: #1D1D1D">
      <q-btn flat rounded dense icon="account_circle" no-caps style="font-weight: bold; margin-right: 15px"></q-btn>
      </router-link>
    </q-toolbar>
    <q-separator class="absolute-center" style="width: 2000px; margin-top:25px; color: #f5f5f5"></q-separator>
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
a {
  color: #171717;
}
</style>

<script setup>
  import { ref } from 'vue'
  import store from "src/store";

  const liked = ref(true)
</script>
