<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container>
      <div class="text-weight-bold text-grey-10 parent" style="margin: 80px 80px 10px; font-size: 35px; width: 350px ">
        Корзина
      </div>
      <div class="row">
        <div>
          <BucketOrder/>
          <BucketOrder/>
          <BucketOrder/>
        </div>
        <div style="margin-left: 100px; position: fixed; left: 850px">
          <div class="text-weight-bold text-grey-10" style="font-size: 30px; margin-top: -58px;">Всего товаров</div>
          <div class="q-mt-lg q-mb-sm" style="display: flex;">
            <div>2 товара</div>
            <div style="margin-left: 200px">3 000 ₽</div>
          </div>
          <div class="q-mb-lg" style="display: flex;">
            <div>Доставка</div>
            <div style="margin-left: 196px">1 000 ₽</div>
          </div>
          <q-separator></q-separator>
          <q-btn class="bg-grey-10  text-white full-width q-mt-lg q-pr-sm" no-caps rounded flat>Оформить заказ<q-icon style="margin-left: 150px" name="chevron_right"></q-icon></q-btn>
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
</script>
