<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container>
      <div class="row">
        <div style="margin-left: 150px; margin-top: 80px">
          <div class="text-weight-bold text-grey-10 q-mb-sm" style="font-size: 23px">
            Получатель
          </div>
          <div class="row q-mb-lg">
            <div class="text-grey-10 q-mt-sm" style="font-size: 15px">
              Имя Фамилия, +7 123 456-78-90
            </div>
            <q-btn style="margin-left: 315px; width: 90px" dense flat rounded class="bg-grey-3 text-grey-9 q-mr-sm" no-caps label="Изменить"/>
          </div>
          <q-separator/>

          <div class="text-weight-bold text-grey-10 q-mb-sm q-mt-md" style="font-size: 23px">
            Способ оплаты
          </div>
          <div class="row">
            <div class="q-mb-md q-mr-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="home"/>
                <q-btn dense size="sm" color="grey-7" round outline style="width: 10px; height: 10px; margin-top: 10px; margin-left: 118px"/>
              </div>
              <div class="text-grey-10" style="font-size: 15px; margin-left: 10px; margin-bottom: 10px;">
                При получении товара
              </div>
            </div>
            <div class="q-mb-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="add_card"/>
                <q-btn dense size="sm" color="grey-7" round outline style="width: 10px; height: 10px; margin-top: 10px; margin-left: 118px"/>
              </div>
              <div class="text-grey-10" style="font-size: 15px; margin-left: 10px; margin-bottom: 10px;">
                Онлайн
              </div>
            </div>
          </div>

          <q-separator class="q-mt-lg"/>

          <div class="text-weight-bold text-grey-10 q-mb-sm q-mt-md" style="font-size: 23px">
            Пункт выдачи
          </div>
          <div class="row">
            <div class="q-mb-md q-mr-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="home"/>
                <div class="text-grey-10 q-my-sm" style="font-size: 14px; margin-left: 10px; margin-bottom: 10px;">Владивосток, <br>улица Кирова, 28</div>
              </div>
            </div>
            <div class="q-mb-md q-mr-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="home"/>
                <div class="text-grey-10 q-my-sm" style="font-size: 14px; margin-left: 10px; margin-bottom: 10px;">Владивосток, <br>улица Кирова, 28</div>
              </div>
            </div>
            <div class="q-mb-md" style="border: 1px solid #bebebe; border-radius: 8px; width: 200px;">
              <div class="row">
                <q-icon style="margin: 10px" color="grey-7" size="25px" name="home"/>
                <div class="text-grey-10 q-my-sm" style="font-size: 14px; margin-left: 10px; margin-bottom: 10px;">Владивосток, <br>улица Кирова, 28</div>
              </div>
            </div>
          </div>
          <div class="row parent">
            <q-btn outline color="grey-9" dense round icon="chevron_left"/>
            <div class="q-mx-sm" style="margin-top: 6px">1</div>
            <div style="margin-top: 6px">2</div>
            <div class="q-mx-sm" style="margin-top: 6px">3</div>
            <q-btn outline color="grey-9" dense round icon="chevron_right"/>
          </div>
          <q-separator class="q-mt-lg q-mb-lg"/>
          <div class="text-weight-bold text-grey-10 q-mb-sm" style="font-size: 23px">
            Состав заказа
          </div>
          <PaymentProduct/>
          <PaymentProduct/>
          <PaymentProduct/>
          <q-separator/>
        </div>
        <div style="margin-left: 100px; position: fixed; left: 850px; top: 170px">
          <div class="row">
            <div class="text-weight-bold text-grey-10" style="font-size: 26px; margin-top: -55px;">Итого</div>
            <div class="text-weight-bold text-grey-10" style="font-size: 30px; margin-top: -60px; margin-left: 140px">3 000 ₽</div>
          </div>
          <div class="q-mt-lg q-mb-sm" style="display: flex;">
            <div>2 товара</div>
            <div style="margin-left: 200px">3 000 ₽</div>
          </div>
          <div class="q-mb-lg" style="display: flex;">
            <div>Доставка</div>
            <div style="margin-left: 196px">1 000 ₽</div>
          </div>
          <q-separator></q-separator>
          <router-link to="/payment">
            <q-btn class="bg-grey-10  text-white full-width q-mt-lg q-pr-sm" no-caps rounded flat>Оформить заказ<q-icon style="margin-left: 150px" name="chevron_right"></q-icon></q-btn>
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
a {
  color: transparent;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import PaymentProduct from "components/PaymentProduct.vue";
</script>
