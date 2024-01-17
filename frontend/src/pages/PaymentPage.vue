<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container v-if="state">
      <div class="row" v-if="!isPayed">
        <div  style="margin-left: 150px; margin-top: 80px">
          <div  class="text-weight-bold text-grey-10 q-mb-sm" style="font-size: 23px">
            Получатель
          </div>
          <div  class="row q-mb-lg">
            <div class="text-grey-10 q-mt-sm" style="font-size: 15px">
              {{ userData.name }}, {{ userData.phone }}
            </div>
          </div>
          <q-separator/>
          <div class="text-weight-bold text-grey-10 q-mb-sm q-mt-md" style="font-size: 23px">
            Способ оплаты
          </div>
          <div class="row">
            <div class="q-mb-md q-mr-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="home"/>
              </div>
              <div class="text-grey-10" style="font-size: 15px; margin-left: 10px; margin-bottom: 10px;">
                При получении товара
              </div>
            </div>
<!--            <div class="q-mb-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px">-->
<!--              <div class="row">-->
<!--                <q-icon style="margin: 10px" color="grey-7" size="25px" name="add_card"/>-->
<!--                <q-btn dense size="sm" color="grey-7" round outline style="width: 10px; height: 10px; margin-top: 10px; margin-left: 118px"/>-->
<!--              </div>-->
<!--              <div class="text-grey-10" style="font-size: 15px; margin-left: 10px; margin-bottom: 10px;">-->
<!--                Онлайн-->
<!--              </div>-->
<!--            </div>-->
          </div>
          <q-separator class="q-mt-lg"/>
          <div class="text-weight-bold text-grey-10 q-mb-sm q-mt-md" style="font-size: 23px">
            Пункт выдачи
          </div>
          <div class="row">
            <div v-for="point in points" :key="point.id" class="q-mb-md q-mr-md clickable"
                 style="border-radius: 8px; width: 200px" @click="choosePoint(point.id)"
            :style="{ ...picked_point === point.id ? { 'border': '1px solid grey', 'background-color': '#eeeeee' } : { 'border': '1px solid #bebebe' } }">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="home"/>
                <div class="text-grey-10 q-my-sm" style="font-size: 14px; margin-left: 10px; margin-bottom: 10px;">{{ point.city_name }}, <br>{{ point.name }}</div>
              </div>
            </div>
          </div>
          <q-separator class="q-mt-lg q-mb-lg"/>
          <div class="text-weight-bold text-grey-10 q-mb-sm" style="font-size: 23px">
            Состав заказа
          </div>
          <PaymentProduct v-for="product in store.state.order" :key="product.id" :id="product.id"
          :name="product.name" :size="product.size" :color="product.color" :photo="product.photo"
          :price="product.price"/>

        </div>
        <div style="margin-left: 100px; position: fixed; left: 850px; top: 170px">
          <div class="row">
            <div class="text-weight-bold text-grey-10" style="font-size: 26px; margin-top: -55px;">Итого</div>
            <div class="text-weight-bold text-grey-10" style="font-size: 30px; margin-top: -60px; margin-left: 180px">{{ sum }} ₽</div>
          </div>
          <div class="q-mt-lg q-mb-sm" style="display: flex;">
            <div>Количество товаров: {{ count }}</div>
            <div style="margin-left: 110px">{{ sum }} ₽</div>
          </div>
          <div class="q-mb-lg" style="display: flex;">
            <div>Доставка</div>
            <div style="margin-left: 196px">{{ sum * 0.2 }} ₽</div>
          </div>
          <q-separator></q-separator>
          <router-link to="/payment">
            <q-btn @click="makeOrder" class="bg-grey-10  text-white full-width q-mt-lg q-pr-sm" no-caps rounded flat>Оформить заказ<q-icon style="margin-left: 150px" name="chevron_right"></q-icon></q-btn>
          </router-link>
          <p style="margin-top: 10px; text-align: center">{{ error }}</p>
        </div>
      </div>
      <div v-else>
        <p class="text-weight-bold text-grey-10" style="text-align: center; font-size: 1.5em; margin-top: 100px" >Заказ успешно оформлен!</p>
        <p class="text text-grey-5" style="text-align: center; font-size: 1.0em;">Спасибо, что выбираете нас</p>
        <p style="text-align: center; font-size: 2em;">/ᐠ_ ꞈ _ᐟ\ɴʏᴀ~</p>
        <router-link to="/categories">
        <q-btn style="width: 200px; left: 50%; transform: translate(-50%, 0);" class="bg-grey-10 text-white q-mt-lg" no-caps rounded>Вернуться к товарам</q-btn>
        </router-link>
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
a {
  color: transparent;
}

.clickable:hover {
  cursor: pointer;
  background-color: #eeeeee;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import PaymentProduct from "components/PaymentProduct.vue";
import {onMounted, reactive, ref} from "vue";
import store from "src/store";

let userData = reactive({
  name: '',
  phone: ''
})

let points = reactive([])
let state = ref(false)
let picked_point = ref(0)
let sum = ref(0)
let count = ref(0)
let error = ref('')
let isPayed = ref(false)

onMounted(async () => {
  const response_user = await fetch('https://onlinestore.poslam.ru/api/v1/user/view', {
    method: 'GET',
    headers: {'auth': `${store.state.token}`},
  })
  const json_user = await response_user.json()
  userData.name = json_user['first_name']
  userData.phone = json_user['phone_number']

  const response_pickup = await fetch('https://onlinestore.poslam.ru/api/v1/pickpoint/view', {
    method: 'GET',
    headers: {'auth': `${store.state.token}`},
  })
  points = await response_pickup.json()

  for (let product in store.state.order) {
    sum.value += store.state.order[product].price
    count.value++
  }

  state.value = true
})

function choosePoint(id) {
  picked_point.value = id
}

async function makeOrder() {

  if (store.state.order.length === 0) {
    error.value = 'Список товаров пуст!'
    return
  }

  if (picked_point.value === 0) {
    error.value = 'Выберите пункт выдачи!'
    return
  }

  let strArray = []
  for (let product in store.state.order) {
    strArray.push(String(store.state.order[product].id))
  }
  let query = strArray.join(', ')

  const data = reactive({
    pickpoint_id: picked_point,
    product_ids: query
  })

  const response = await fetch('https://onlinestore.poslam.ru/api/v1/order/add', {
    method: 'POST',
    headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`},
    credentials: 'include',
    body: JSON.stringify(data)
  })

  if (response.status === 200) {
    await store.dispatch('setOrder', [])
    sum.value = 0
    count.value = 0
    error.value = 'Заказ оформлен успешно!'
    isPayed.value = true
  }
  else {
    error.value = 'Не удалось оформить заказ!'
  }
}
</script>
