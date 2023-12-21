<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="flex flex-center bg-grey-2">
        <q-card class="q-px-lg q-pt-md q-pb-xl shadow-2 my_card" bordered>
          <q-card-section class="text-center">
            <div class="text-grey-9 text-h6 text-weight-bold q-mb-xl ">=＾• ⋏ •＾=</div>
            <div class="text-grey-9 text-h5 text-weight-bold" style="margin-bottom: 5px">Восстановление пароля</div>
            <div  class="text-grey-7 text-h7 ">Укажите свой адрес электронной почты, мы отправим вам электронное письмо с инструкциями о том, как создать новый пароль</div>
          </q-card-section>
          <q-card-section>
              <div class="text-grey-9 text-weight-bold q-ma-sm">Email</div>
              <q-input dense outlined rounded color="dark" v-model="email" label="Введите email"><template v-slot:prepend></template></q-input>

          </q-card-section>
          <q-card-section>
            <div class="row" >
              <router-link to="/">
                <q-btn class="btn-l" color="dark" rounded outline size="md" style="padding: 9px" label="Отмена" no-caps ></q-btn>
              </router-link>
              <router-link to="/">
                <q-btn class="btn-r" color="dark" rounded size="md" style="padding: 9px" label="Отправить" no-caps ></q-btn>
              </router-link>
            </div>

          </q-card-section>


        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<style>

.btn-l {
  width: 152px;
  margin-right: 10px;
  border: 1.5px solid black;
}
.btn-r {
  width: 152px;
  margin-left: 10px;

}
.my_card {
  width: 450px;
  padding-left: 40px;
  padding-right: 40px;
  border-radius: 50px;
  box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
}
a {
  color: transparent;
}
</style>

<script>
import { defineComponent } from 'vue'
export default defineComponent({
  name: 'ResetPassword',

})
</script>
