<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container >
      <div class="text-weight-bold text-grey-10 parent q-mt-lg q-mb-sm" style="font-size: 35px;">
        Категории
      </div>
      <div class="text-grey-6 parent q-mb-sm" style="font-size: 15px; text-align: center">
        Эксклюзивная одежда с котиками: стиль, удобство и невероятная милота в каждой вещи.<br> Обновите свой гардероб пушистыми трендами прямо сейчас!
      </div>
      <div class="parent q-mt-lg q-mb-xl">
        <q-btn
          v-for="(button, index) in buttons"
          :key="index"
          :class="{ 'active': activeButton === index }"
          @click="setActiveButton(index)"
          rounded
          flat
          class="text-weight-bold q-py-sm q-px-md"
          style="border: 1.5px solid #3a3a3a; font-size: 13px"
          :style="{ 'margin-right': '8px', ...activeButton === index ? activeButtonStyle : {} }"
        >
          {{ button }}
        </q-btn>
      </div>
      <div class="row parent" style="margin-bottom: 100px">
        <ProductComponent/>
        <ProductComponent/>
        <ProductComponent/>
        <ProductComponent/>
      </div>
      <div class="row parent" style="margin-bottom: 100px">
        <ProductComponent/>
        <ProductComponent/>
        <ProductComponent/>
        <ProductComponent/>
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
import {onMounted} from "vue";
import store from "src/store";

let categories_json = []

onMounted(async () => {
    const response = await fetch('https://onlinestore.poslam.ru/api/v1/category/view', {
      method: 'GET',
      headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`}
    })
    categories_json = await response.json()
    // console.log(categories_json[0].id)
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
