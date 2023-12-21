<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>

    <q-page-container>
      <div class="q-pa-md q-gutter-md row items-start" style="margin: 100px 200px ">
        <q-card style=" width: 380px; box-shadow: none; border-radius: 25px">
          <q-btn  @click="orders" flat icon="local_shipping"  text-color="grey-10" class="btn_start full-width  text-weight-bold" label="Мои заказы" :style="{border: order ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 205px" name="chevron_right"></q-icon></q-btn>
          <q-btn  @click="manage_acc" flat icon="settings" text-color="grey-10" class="btn_center_dark full-width text-weight-bold" label="Управление аккаунтом" :style="{border: order ? '' : '2px solid #3a3a3a'}" no-caps ><q-icon style="margin-left: 130px" name="chevron_right"></q-icon></q-btn>
          <q-btn  flat icon="home" text-color="grey-10" class="btn_center_light full-width text-weight-bold" label="Адреса доставки" no-caps ><q-icon style="margin-left: 165px" name="chevron_right"></q-icon></q-btn>
          <q-btn  flat icon="credit_card"  text-color="grey-10" class="btn_center_dark full-width text-weight-bold" label="Способы оплаты" no-caps ><q-icon style="margin-left: 165px" name="chevron_right"></q-icon></q-btn>
          <q-btn  flat icon="logout" text-color="grey-10" class="btn_end full-width text-weight-bold" label="Выход" no-caps ><q-icon style="margin-left: 235px" name="chevron_right"></q-icon></q-btn>
        </q-card>
        <template v-if="order">
          <q-card style=" width: 380px; box-shadow: none; border-radius: 25px; margin-top: -38px">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 270px 20px; font-size: 30px ">Заказы</div>
            <div class="q-pa-md" style="width: 640px; border-radius: 25px; background-color: #f6f6f6;">
              <div class="row q-mb-xl">
                <q-btn @click="change" flat rounded :style="{border: active ? '2.5px solid #3a3a3a' : '1px solid #3a3a3a'}" label="Активные" no-caps class="btn_change text-weight-bold text-grey-10"></q-btn>
                <q-btn @click="change2" flat rounded :style="{border: active ? '1px solid #3a3a3a' : '2.5px solid #3a3a3a'}" label="Архив" no-caps class="btn_change text-weight-bold q-ml-sm text-grey-10 "></q-btn>
              </div>
              <template v-if="active">
                <div class="q-pl-sm" style="font-size: 14.5px; ">У вас нет активных заказов</div>
                <q-separator color="grey-5" class="q-mt-md q-mb-sm"/>
              </template>
              <template v-else>
                <div class="q-pl-sm" style="font-size: 14.5px; ">У вас нет заказов в архиве</div>
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
.btn_start{
  padding: 9px 9px 9px 15px;
  border-start-start-radius: 23px;
  border-start-end-radius: 23px;
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
      active2: false,
      order: false,
      manage: false
    };
  },
  methods: {
    change() {
      this.active = true;
      this.active2 = false;
    },
    change2() {
      this.active2 = true;
      this.active = false;
    },
    orders() {
      this.order = true;
      this.manage = false;
    },
    manage_acc() {
      this.manage = true;
      this.order = false;
    }
  }
};
</script>
