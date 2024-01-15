<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container v-if="state">
      <div class="row q-mt-xl">
        <div style="margin-left: 245px">
<!--          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">-->
<!--            <q-icon size="80px" color="grey-9" name="mood" />-->
<!--          </div>-->
<!--          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">-->
<!--            <q-icon size="80px" color="grey-9" name="mood" />-->
<!--          </div>-->
<!--          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">-->
<!--            <q-icon size="80px" color="grey-9" name="mood" />-->
<!--          </div>-->
<!--          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">-->
<!--            <q-icon size="80px" color="grey-9" name="mood" />-->
<!--          </div>-->
        </div>
        <div class="bg-brown-2 q-ma-md q-pa-md parent square-icon-container" style="border-radius: 15px; display: flex; align-items: center; justify-content: center; width: 500px">
         <div v-if="current_product[0].photo[0]" style="width: 120px; height: 120px; overflow: hidden; border-radius: 20px; position: relative;">
          <img :src="current_product[0].photo[0]" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0;">
        </div>
        <q-icon v-else size="180px" color="dark" name="mood" />
        </div>
        <div style="margin-left: 30px">
          <div class="text-weight-bold text-grey-10 q-mt-md" style="font-size: 23px">
            {{ current_product[0].name }}
          </div>
          <div class="text-weight-bold text-dark q-mt-md" style="font-size: 30px">
            {{ current_product[0].price }}
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Описание
          </div>
          <div class="text-grey-10" style="font-size: 15px; margin: 0 auto; width: 500px">
           {{ current_product[0].description }}
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Цвет
          </div>
          <div>
            <q-btn v-for="(color, index) in current_product[0].colors" :key="index" flat class="bordered-button">
              <div style="border-radius: 8px; width: 30px; height: 30px"
              :style="{ 'background-color': color.hex_code }"></div>
            </q-btn>
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Размер
          </div>
          <div>
            <q-btn v-for="(size, index) in current_product[0].sizes" :key="index" flat class="bordered-button" :label="size.name"/>
          </div>
          <div class="q-mt-lg">
            <q-btn flat rounded style="width: 200px" class="bg-grey-3 text-grey-9 q-mr-sm" no-caps label="Добавить в корзину"/>
            <q-btn flat rounded style="width: 200px" class="bg-dark text-white" no-caps label="Купить сейчас"/>
          </div>
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
.bordered-button {
  border: 1px solid black;
  border-radius: 10px;
  width: 40px; /* Установите ширину и высоту по вашему выбору */
  height: 40px;
  margin-right: 10px;
  padding: 4px;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import {onMounted, ref} from "vue";
import store from "src/store";

let current_product = null
let state = ref(false)

const props = defineProps({
  id: Number
})

onMounted(async () => {
  current_product = store.state.products.filter(item => item.id === Number(props.id))
  state.value = true
})

</script>


<script>
</script>
