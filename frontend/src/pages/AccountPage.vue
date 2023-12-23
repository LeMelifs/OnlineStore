<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>

    <q-page-container>
      <div class=" q-gutter-md row items-start" style="margin: 100px 200px ">
        <q-card style=" width: 380px; box-shadow: none; border-radius: 25px">
          <q-btn  @click="orders" flat icon="local_shipping"  text-color="grey-10" class="btn_start full-width  text-weight-bold" label="Мои заказы" :style="{border: manage ? '' : '2px solid #3a3a3a'}" no-caps ><q-icon style="margin-left: 205px" name="chevron_right"></q-icon></q-btn>
          <q-btn  @click="manage_acc" flat icon="settings" text-color="grey-10" class="btn_center_dark full-width text-weight-bold" label="Управление аккаунтом" :style="{border: manage ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 130px" name="chevron_right"></q-icon></q-btn>
          <q-btn  flat icon="home" text-color="grey-10" class="btn_center_light full-width text-weight-bold" label="Адреса доставки" no-caps ><q-icon style="margin-left: 165px" name="chevron_right"></q-icon></q-btn>
          <q-btn  flat icon="credit_card"  text-color="grey-10" class="btn_center_dark full-width text-weight-bold" label="Способы оплаты" no-caps ><q-icon style="margin-left: 165px" name="chevron_right"></q-icon></q-btn>
          <router-link to="/">
            <q-btn  flat icon="logout" text-color="grey-10" class="btn_end full-width text-weight-bold" label="Выход" no-caps ><q-icon style="margin-left: 235px" name="chevron_right"></q-icon></q-btn>
          </router-link>
        </q-card>
        <template v-if="manage">
          <q-card style=" width: 650px; box-shadow: none; border-radius: 25px; margin-top: -38px;">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 150px 20px; font-size: 30px; width: 350px ">Управление аккаунтом</div>
            <div class="q-pa-md" style="width: 640px; border-radius: 25px; background-color: #f6f6f6; margin-bottom: -100px">
              <div class="row">
                <q-card style="box-shadow: none; border-radius: 25px; height: 150px">
                  <q-card-section class="bg-brown-2">
                    <q-icon size="120px" color="dark" name="account_circle" />
                  </q-card-section>
                </q-card>
                <q-btn flat rounded style="width: 50px; height: 50px; background-color: #ffffff; border: 1px solid #a4a4a4; margin: 100px 0px 0px -20px" dense icon="edit"></q-btn>
                <q-input dense outlined rounded color="dark" style="width: 410px; background-color: white; border-radius: 25px; height: 40px; margin: 110px 0px 0px 15px"  label="Имя пользователя"><template v-slot:prepend></template></q-input>
              </div>
              <div style="margin: 50px 0px 4px 15px; font-size: 14px">Почта</div>
              <q-btn style="border: 1px solid #a4a4a4; padding: 7px 0px 7px 10px; font-size: 15px" rounded flat text-color="grey-10" class="full-width text-weight-bold"  label="popik@mail.ru" no-caps ><q-icon style="margin-left: 450px" name="chevron_right"></q-icon></q-btn>
              <div style="margin: 15px 0px 4px 15px; font-size: 14px">Телефон</div>
              <q-btn style="border: 1px solid #a4a4a4;margin: 0px 0px 50px 0px; padding: 7px 0px 7px 10px" rounded flat text-color="grey-10" class="full-width text-h7 text-weight-bold" label="+7 (123) 456-89-00" no-caps ><q-icon style="margin-left: 420px" name="chevron_right"></q-icon></q-btn>
              <router-link to="/">
                <a class="text-grey-9 text-weight-bold" style="margin: 0px 0px 4px 10px;">Изменить пароль</a>
              </router-link>
              <div style="margin: 15px 0px 4px 10px;">
                <router-link to="/">
                  <a class="text-grey-9 text-weight-bold" >Удалить аккаунт</a>
                </router-link>
              </div>
            </div>
          </q-card>
        </template>
        <template v-else>
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
.btn_center_light{
  padding: 9px 9px 9px 15px;
  border-radius: 0px;
  border-bottom: 0px solid #b0b0b0;
  border-top: 0px solid #b0b0b0;
  background-color: #f6f6f6;
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
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
</script>

<script>
export default {
  data() {
    return {
      active: false,
      order: false,
      manage: false
    };
  },
  methods: {
    change_t() {
      this.active = true;
    },
    change_f() {
      this.active = false;
    },
    manage_acc() {
      this.order = false;
      this.manage = true;
    },
      orders() {
      this.order = true;
      this.manage = false;
    }
  }
};
</script>
