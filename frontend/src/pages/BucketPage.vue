<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container v-if="state">
      <div class="row">
        <div class="text-weight-bold text-grey-10 parent" style="margin: 80px 80px 10px; font-size: 35px; width: 350px ">
          Корзина
        </div>
        <div v-if="products_cart.length !== 0" class="round" style="margin-left: 205px; margin-top:94px">
          <input type="checkbox" id="checkbox" v-model="status" />
          <label for="checkbox">
            <div class="checkmark" v-if="status"></div>
          </label>
        </div>
      </div>
      <div class="row">
        <div>
          <BucketOrder v-for="(product, index) in products_cart" :key="index" :name="product.name" :id="product.id"
          :price="product.price" :size="product.size['name']" :color="product.color['name']" :photo="product.photo"
          :status="status"/>
        </div>
        <div style="margin-left: 100px; position: fixed; left: 850px">
          <div class="text-weight-bold text-grey-10" style="font-size: 30px; margin-top: -58px;">Оформите заказ</div>
          <div class="q-mt-lg q-mb-sm" style="display: flex;">
            <div>Количество товаров: {{ products_count }}</div>
            <div style="margin-left: 110px">{{ products_price }} ₽</div>
          </div>
          <div class="q-mb-lg" style="display: flex;">
            <div>Доставка</div>
            <div style="margin-left: 196px">{{ products_price * 0.2 }} ₽</div>
          </div>
          <q-separator></q-separator>
          <router-link to="/payment">
            <q-btn class="bg-grey-10  text-white full-width q-mt-lg q-pr-sm" no-caps rounded flat>К оформлению<q-icon style="margin-left: 150px" name="chevron_right"></q-icon></q-btn>
          </router-link>
        </div>
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
import BucketOrder from "components/BucketOrder.vue";
import {onMounted, onUnmounted, ref} from "vue";
import store from "src/store";

let products_cart = ref(null)
let products_count = ref(Number)
let products_price = ref(Number)
let state = ref(false)
let status = ref(false)

onMounted(async () => {
  const response_products = await fetch('https://onlinestore.poslam.ru/api/v1/bin/view', {
      method: 'GET',
      headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`}
    })
    const json = await response_products.json()
    products_cart.value = json['products']
    products_count.value = json['count']
    products_price.value = json['sum']
    state.value = true
})
</script>
