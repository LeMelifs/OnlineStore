<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container v-if="state">
      <div class="row q-mt-xl">
        <div style="margin-left: 15%">
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
        <div class="bg-brown-2 q-mx-md  parent" style="margin-top: 20px; margin-right: 70px; border-radius: 20px; position: relative; width: 450px; height: 450px;">
          <div v-if="current_product[0].photo[0]" style="width: 100%; height: 100%; overflow: hidden; border-radius: 20px; position: absolute; top: 0; left: 0;">
            <v-lazy-image :src="current_product[0].photo[0]" alt="Avatar" style="width: 100%; height: 100%;
            object-fit: cover;" :src-placeholder="current_product[0].photo[1]" />
          </div>
          <q-icon v-else style="margin-top: 40px" size="180px" color="dark" name="mood" />
        </div>

        <div style="margin-left: 30px">
          <div class="text-weight-bold text-grey-10 q-mt-md" style="font-size: 23px">
            {{ current_product[0].name }}
          </div>
          <div class="text-weight-bold text-dark q-mt-md" style="font-size: 33px">
            {{ current_product[0].price }} ₽
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-lg q-mb-sm" style="font-size: 18px">
            Описание
          </div>
          <div class="text-grey-10" style="font-size: 15px; margin: 0 auto; width: 500px">
           {{ current_product[0].description }}
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Цвет
          </div>
          <div>
            <q-btn v-for="(color, index) in current_product[0].colors" :key="index" @click="setColor(color.id)" flat class="bordered-button">
              <div style="border-radius: 8px; width: 30px; height: 30px"
              :style="{ 'background-color': color.hex_code }"></div>
            </q-btn>
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Размер
          </div>
          <div>
            <q-btn v-for="(size, index) in current_product[0].sizes" :key="index" flat class="bordered-button"
                   :label="size.name" @click="setSize(size.id)"/>
          </div>
          <div style="margin-top: 50px">
            <q-btn @click="addToCart" flat rounded style="width: 200px; height: 40px" class="bg-grey-3 text-grey-9 q-mr-sm" no-caps label="Добавить в корзину"/>
            <router-link to="/payment">
            <q-btn @click="buyNow" flat rounded style="width: 200px; height: 40px" class="bg-dark text-white" no-caps label="Купить сейчас"/>
            </router-link>
          </div>
          <p style="margin-top: 20px">{{ error }}</p>
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

.v-lazy-image {
  filter: blur(10px);
  transition: filter 0.7s;
}
.v-lazy-image-loaded {
  filter: blur(0);
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import {onMounted, ref} from "vue";
import store from "src/store";
import VLazyImage from "v-lazy-image";

let current_product = null
let state = ref(false)
let picked_size = null
let picked_color = null
let error = ref('')
const params = new URLSearchParams();
const url = 'https://onlinestore.poslam.ru/api/v1/bin/add'

const props = defineProps({
  id: Number
})

onMounted(async () => {
  current_product = store.state.products.filter(item => item.id === Number(props.id))
  state.value = true
})

function setSize(size) {
  picked_size = size
}

function setColor(color) {
  picked_color = color
}

async function buyNow() {
  store.state.order.push({ id: current_product[0].id, name: current_product[0].name, size: current_product[0].size,
    color: current_product[0].color, photo: current_product[0].photo, price: current_product[0].price,
    status: current_product[0].status })
  await store.dispatch('setOrder', store.state.order)
}

async function addToCart() {
  if (store.state.token === null) {
    error.value = 'Вы не авторизованы!'
    return
  }

  params.append('product_id', current_product[0].id)

  if (picked_size === null) {
    error.value = 'Выберите размер!'
    params.delete('product_id')
    return
  }
  else {
    params.append('size_id', picked_size)
  }

  if (picked_color === null) {
    error.value = 'Выберите цвет!'
    params.delete('product_id')
    params.delete('size_id')
    return
  }
  else {
    params.append('color_id', picked_color)
  }

  const fullUrl = `${url}?${params.toString()}`;
  console.log(fullUrl)

  const response = await fetch(fullUrl, {
    method: 'POST',
    headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`},
    credentials: 'include'
  })

  if (response.status === 401) {
    error.value = 'Вы не авторизованы!'
  }
  else if (response.status === 200) {
    error.value = 'Товар успешно добавлен в корзину!'
  }

  params.delete('product_id')
  params.delete('size_id')
  params.delete('color_id')
}

</script>


<script>
</script>
