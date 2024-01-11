<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container>
      <div class="row q-mt-xl">
        <div style="margin-left: 80px">
          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">
            <q-icon size="80px" color="grey-9" name="mood" />
          </div>
          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">
            <q-icon size="80px" color="grey-9" name="mood" />
          </div>
          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">
            <q-icon size="80px" color="grey-9" name="mood" />
          </div>
          <div class="bg-brown-2 q-ma-md q-pa-md parent" style="border-radius: 10px">
            <q-icon size="80px" color="grey-9" name="mood" />
          </div>
        </div>
        <div class="bg-brown-2 q-ma-md q-pa-md parent square-icon-container" style="border-radius: 15px; display: flex; align-items: center; justify-content: center; width: 500px">
          <q-icon size="300px" color="grey-9" name="mood" />
        </div>
        <div style="margin-left: 30px">
          <div class="text-weight-bold text-grey-10 q-mt-md" style="font-size: 23px">
            Футболка смайл фэйс
          </div>
          <div class="text-weight-bold text-dark q-mt-md" style="font-size: 30px">
            150 ₽
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Описание
          </div>
          <div class="text-grey-10" style="font-size: 15px; margin: 0 auto; width: 500px">
            Добро пожаловать в мир безудержного веселья с футболкой «Силли Фэйс»! Этот бэнгер стиля обещает уровень глупенькости, который взорвет ваши ожидания. Декорирована котятами, она перевернет ваш облик, а Кирби просто потеряет дыхание от восторга. Отважьтесь на веселый поворот в своем гардеробе!
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Цвет
          </div>
          <div>
            <q-btn flat class="bordered-button">
              <div style="background-color: #d8a5f5; border-radius: 8px; width: 30px; height: 30px"></div>
            </q-btn>
            <q-btn flat class="bordered-button">
              <div style="background-color: #8686e8; border-radius: 8px; width: 30px; height: 30px"></div>
            </q-btn>
            <q-btn flat class="bordered-button">
              <div style="background-color: #ffa6e3; border-radius: 8px; width: 30px; height: 30px"></div>
            </q-btn>
          </div>
          <div class="text-weight-bold text-grey-10 q-mt-md q-mb-sm" style="font-size: 18px">
            Размер
          </div>
          <div>
            <q-btn flat class="bordered-button" label="XS"/>
            <q-btn flat class="bordered-button" label="S"/>
            <q-btn flat class="bordered-button" label="M"/>
            <q-btn flat class="bordered-button" label="L"/>
            <q-btn flat class="bordered-button" label="XL"/>
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
</script>
