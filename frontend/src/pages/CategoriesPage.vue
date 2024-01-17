<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container v-if="state">
      <div class="text-weight-bold text-grey-10 parent q-mt-lg q-mb-sm" style="font-size: 35px;">
        Категории
      </div>
      <div class="text-grey-6 parent q-mb-sm" style="font-size: 15px; text-align: center">
        Эксклюзивная одежда с котиками: стиль, удобство и невероятная милота в каждой вещи.<br> Обновите свой гардероб пушистыми трендами прямо сейчас!
      </div>
      <div class="parent q-mt-lg q-mb-xl">
        <q-btn
          v-for="category in categories_json"
          :key="category.id"
          :class="{ 'active': activeButton === category.id }"
          @click="setActiveButton(category.id)"
          rounded
          flat
          class="text-weight-bold q-py-sm q-px-md"
          style="border: 1.5px solid #3a3a3a; font-size: 13px"
          :style="{ 'margin-right': '8px', ...activeButton === category.id ? activeButtonStyle : {} }"
        >
          {{ category.name }}
        </q-btn>
      </div>
      <div v-for="(separator, idx) in separators" :key="idx" class="row parent" style="margin-bottom: 130px">
        <ProductComponent v-for="(product, index) in products_json.filter(item => item.category_id === activeButton)
        .slice(separator - 4, separator)" :key="index" :name="product.name" :description="product.description"
                                          :price="product.price" :photo="product.photo" :id="product.id"/>
      </div>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>
.parent {
  display: flex;
  justify-content: center;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import ProductComponent from "components/ProductComponent.vue"
import {onMounted, ref} from "vue";
import store from "src/store";


let categories_json = []
let products_json = []
let state = ref(false)
const separators = [4, 8]

onMounted(async () => {
    const response_categories = await fetch('https://onlinestore.poslam.ru/api/v1/category/view', {
      method: 'GET',
      headers: {'Content-Type': 'application/json'}
    })
    categories_json = await response_categories.json()

    const response_products = await fetch('https://onlinestore.poslam.ru/api/v1/product/view', {
      method: 'GET',
      headers: {'Content-Type': 'application/json'}
    })
    products_json = await response_products.json()
    await store.dispatch('setProducts', products_json)
    await store.dispatch('setOrder', [])

    state.value = true
})
</script>

<script>
export default {
  data() {
    return {
      buttons: ['Футболки', 'Толстовки', 'Штаны', 'Носки', 'Сумки', 'Аксессуары'],
      activeButton: 0,
      activeButtonStyle: {
        border: '1.5px solid #3a3a3a',
        backgroundColor: '#343434',
        color: 'white'
      }
    };
  },
  methods: {
    setActiveButton(index) {
      this.activeButton = index;
    }
  }
};
</script>
