<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>

    <q-page-container class="parent" style="margin-top: 100px; margin-right: 200px">
      <div class=" q-gutter-md row items-start">
        <q-card style=" width: 380px; box-shadow: none; border-radius: 25px">
          <q-btn  @click="orders" flat icon="local_shipping"  text-color="grey-10" class="btn_start full-width  text-weight-bold" label="Мои заказы" :style="{border: order ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 205px" name="chevron_right"></q-icon></q-btn>
          <q-btn  @click="manage_acc" flat icon="settings" text-color="grey-10" class="btn_center_dark full-width text-weight-bold" label="Управление аккаунтом" :style="{border: manage ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 130px" name="chevron_right"></q-icon></q-btn>
          <router-link to="/login">
            <q-btn @click="logout" flat icon="logout" text-color="grey-10" class="btn_end full-width text-weight-bold" label="Выход" no-caps ><q-icon style="margin-left: 235px" name="chevron_right"></q-icon></q-btn>
          </router-link>
        </q-card>
        <template v-if="manage">
          <q-card style=" width: 380px; box-shadow: none; border-radius: 25px; margin-top: -38px">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 150px 20px; font-size: 30px; width: 350px;">Управление аккаунтом</div>

            <div class="q-pa-md" style="width: 640px; border-radius: 25px; background-color: #f6f6f6; margin-bottom: -100px;">
              <q-form @submit="submit" id="form">
                <div class="row">
                  <q-card style="box-shadow: none; border-radius: 25px; height: 130px;">
                    <q-card-section class="bg-brown-2 q-pa-sm">
                      <div style="width: 120px; height: 120px; overflow: hidden; border-radius: 20px; position: relative;">
<!--                        <v-lazy-image />-->
                        <img :src="data.photo" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0;">
                      </div>
                    </q-card-section>
                  </q-card>

                  <input ref="fileInput" @change="onAddPicture" type="file" style="display: none;">
                  <q-btn @click="$refs.fileInput.click()" flat rounded style="width: 50px; height: 50px; background-color: #ffffff; border: 1px solid #a4a4a4; margin: 82px 0px 0px -25px" dense icon="edit"></q-btn>
                  <div>
                    <q-input dense outlined rounded color="dark" class="q-mb-md q-ml-lg bg-white" style="margin-top: 35px;border-radius: 25px; width: 200%" v-model='data.first_name' label="Ваше имя"><template v-slot:prepend></template></q-input>
                    <q-input dense outlined rounded color="dark" class="q-ml-lg bg-white" style="border-radius: 25px; width: 200%" v-model='data.username' label="Имя пользователя"><template v-slot:prepend></template></q-input>
                  </div>
                </div>

                <div class="text-weight-bold q-ml-sm q-mt-lg q-mb-sm" style="font-size: 14px;">Почта</div>
                  <q-btn style="border: 1px solid #a4a4a4; padding: 7px 10px; font-weight: normal; font-size: 15px; position: relative;" rounded flat text-color="grey-10" class="full-width bg-grey-1" no-caps>
                    <span style="position: absolute; left: 18px; top: 50%; transform: translateY(-50%);">{{ data.email }}</span>
                    <q-icon style="position: absolute; right: 8px; top: 50%; transform: translateY(-50%);" name="chevron_right"></q-icon>
                  </q-btn>
                <div class="text-weight-bold q-ml-sm q-mt-md q-mb-sm" style="font-size: 14px;">Телефон</div>
                <q-btn style="border: 1px solid #a4a4a4; padding: 7px 10px;font-weight: normal; font-size: 15px; position: relative;" rounded flat text-color="grey-10" class="full-width bg-grey-1" no-caps>
                  <span style="position: absolute; left: 18px; top: 50%; transform: translateY(-50%);">{{ data.phone_number }}</span>
                  <q-icon style="position: absolute; right: 8px; top: 50%; transform: translateY(-50%);" name="chevron_right"></q-icon>
                </q-btn>
                <div class="row">
                  <div class="text-weight-bold q-ma-sm" style="margin-top: 15px; margin-bottom: 10px">Пол:</div>
                  <input type="radio" v-model="data.gender" value="м" name="gender" class="radio" style="margin-left: 40px">
                  <span style="margin-top: 15px">Мужчина</span>
                  <input type="radio" v-model="data.gender" value="ж" name="gender" class="radio" style="margin-left: 30px">
                  <span style="margin-top: 15px">Женщина</span>
                </div>

                <div class="row">
                  <div class="col-6">
                    <q-btn class="bg-grey-10 text-grey-2 text-weight-bold q-mt-lg" rounded flat no-caps type="submit" style="width: 98%; font-size: 15px">Сохранить</q-btn>
                  </div>
                  <div class="col-6">
                    <router-link to="/change_password" class="q-ml-xs">
                      <q-btn class="text-weight-bold q-mt-lg q-mb-xs" rounded outline no-caps style="width: 98%; font-size: 15px">Изменить пароль</q-btn>
                    </router-link>
                  </div>
                </div>
                <p style="text-align: center; margin-top: 5px">{{ error }}</p>
              </q-form>
            </div>
          </q-card>
        </template>
        <template v-if="order">
          <q-card style=" width: 380px; box-shadow: none; border-radius: 25px; margin-top: -38px">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 270px 20px; font-size: 30px ">Заказы</div>
            <div class="q-pa-md" style="width: 640px; border-radius: 25px; background-color: #f6f6f6;">
              <div class="row q-mb-xl">
                <q-btn @click="change_f" flat rounded :style="{border: active ? '1px solid #3a3a3a' : '2.5px solid #3a3a3a'}" label="Активные" no-caps class="btn_change text-weight-bold text-grey-10"></q-btn>
                <q-btn @click="change_t" flat rounded :style="{border: active ? '2.5px solid #3a3a3a' : '1px solid #3a3a3a'}" label="Архив" no-caps class="btn_change text-weight-bold q-ml-sm text-grey-10 "></q-btn>
              </div>

              <template v-if="active">
                <div class="q-pl-sm" style="font-size: 14.5px; ">У вас нет заказов в архиве</div>
                <q-separator color="grey-5" class="q-mt-md q-mb-sm"/>
              </template>
              <template v-else>
                <div class="q-pl-sm" style="font-size: 14.5px; ">У вас нет активных заказов</div>
                <q-separator color="grey-5" class="q-mt-md q-mb-sm"/>
              </template>
            </div>
          </q-card>
        </template>

        <template v-if="deliver">
          <q-card style=" box-shadow: none; border-radius: 25px; margin-top: -38px;">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 15px 20px; font-size: 30px;padding-left: 40px">Адреса доставки</div>
            <div class="q-pa-lg" style=" border-radius: 25px; background-color: #f6f6f6; margin-bottom: -100px;">
              <q-icon name="person" style="font-size: 25px" />
              <span style="margin: 5px 0px 4px 15px; font-size: 14px; font-weight: bold">Имя Фамилия Отчество, +7 (123) 456-78-90</span>
              <div class="q-mt-sm q-mb-md">
                <q-icon name="room" style="font-size: 25px" />
                <span style="margin: 5px 0px 4px 15px; font-size: 14px;">Улица 12, кв. 34</span>
                <div style="margin-left: 40px">Владивосток г, Приморский край, 120034</div>
              </div>
              <router-link to="/">
                <a class="text-grey-9 text-weight-bold" style="margin: 0px 0px 4px 40px;">Редактировать</a>
              </router-link>
              <span style="margin: 10px 0px 4px 10px;">
                <router-link to="/">
                  <a class="text-grey-9 text-weight-bold" >Удалить</a>
                </router-link>
              </span>
            </div>
          </q-card>
        </template>
        <template v-else>
        </template>
      </div>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>

a {
  color: #2f2f2f;
}
.btn_start{
  padding: 9px 9px 9px 15px;
  border-start-start-radius: 25px;
  border-start-end-radius: 25px;
  background-color: #f6f6f6;
}
.btn_center_dark{
  padding: 9px 9px 9px 15px;
  border-radius: 0px;
  border-bottom: 0px solid #b0b0b0;
  border-top: 0px solid #b0b0b0;
  background-color: #eeeeee;
}
.btn_end{
  padding: 9px 9px 9px 15px;
  border-end-end-radius: 24px;
  border-end-start-radius: 24px;
  background-color: #f6f6f6;
}
.btn_change{
  padding: 8px;
  width: 300px;
  background-color: white;
  font-size: 16px;
}
.radio {
  accent-color: #1D1D1D;
  margin-left: 5px;
  margin-right: 10px;
  margin-top: 5px;
}
.parent {
  display: flex;
  justify-content: center;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import {onMounted, reactive, ref} from "vue";
import store from "src/store";
import VLazyImage from "v-lazy-image";

let active = ref(false)
let order = ref(false)
let manage = ref(false)
let blob = ref()
let filename = ref('')
const changed = {}
let error = ref('')

onMounted(() => {
  order.value = true;
  manage.value = false;
})

const data = reactive({
  username: '',
  first_name: '',
  email: '',
  gender: '',
  phone_number: '',
  photo: null
})

const defaultForm = {
  username: '',
  first_name: '',
  gender: '',
  email: '',
  phone_number: '',
  photo: null
}

function onAddPicture(e) {
  if (e.target.files[0]['type'] === 'image/jpeg' || e.target.files[0]['type'] === 'image/png') {
    blob.value = e.target.files[0];
    filename.value = blob.value.name;
    const reader = new FileReader();
    reader.readAsDataURL(blob.value);
    reader.onload = e => {
      data.photo = e.target.result;
    };
  }
  else {
    alert('Файл изображения должен иметь расширение .jpeg или .png')
  }
}

onMounted(async () => {
  const response = await fetch('https://onlinestore.poslam.ru/api/v1/user/view', {
    method: 'GET',
    headers: {'auth': `${store.state.token}`},
  })

  const json = await response.json()

  if (response.status !== 400) {
    data.username = json['username']
    defaultForm.username = data.username
    data.first_name = json['first_name']
    defaultForm.first_name = data.first_name
    data.email = json['email']
    defaultForm.email = data.email
    data.gender = json['gender']
    defaultForm.gender = data.gender
    data.phone_number = json['phone_number']
    defaultForm.phone_number = data.phone_number
    data.photo = json['photo'][0]
    defaultForm.photo = data.photo
  }
})

const submit = async () => {

  let avatarChanged = false

  for (const [key] of Object.entries(defaultForm)) {
    if (defaultForm[key] !== data[key]) {
      if (key === 'photo')
        avatarChanged = true
      else changed[key] = data[key]
    }
  }

  let isEditSuccess = true
  let isPhotoEditSuccess = true

  if (Object.keys(changed).length !== 0) {
    const response = await fetch('https://onlinestore.poslam.ru/api/v1/user/edit', {
      method: 'POST',
      headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`},
      credentials: 'include',
      body: JSON.stringify(changed)
    })

    if (response.status !== 200)
      isEditSuccess = false
  }

  if (avatarChanged) {
    const formData = new FormData()
    formData.append("files", blob.value, filename.value)
    const response = await fetch('https://onlinestore.poslam.ru/api/v1/upload', {
      method: 'POST',
      headers: { 'auth': `${store.state.token}`},
      body: formData
    })

    if (response.status !== 200)
      isPhotoEditSuccess = false
  }

  if (Object.keys(changed).length === 0 && !avatarChanged) {
    error.value = 'Изменения не обнаружены'
    return
  }

  if (isEditSuccess && isPhotoEditSuccess)
    error.value = 'Изменения сохранены!'
  else error.value = 'Некорректные данные!'
}

function logout() {
  store.dispatch('setToken', null)
  store.dispatch('setRefreshToken', null)
  store.dispatch('setType', null)
  store.dispatch('setAuth', false)
}

function change_t() {
  active.value = true;
  error.value = ''
}

function change_f() {
  active.value = false;
  error.value = ''
}

function manage_acc() {
  order.value = false;
  manage.value = true;
  error.value = ''
}

function orders() {
  order.value = true;
  manage.value = false;
  error.value = ''
}
</script>

