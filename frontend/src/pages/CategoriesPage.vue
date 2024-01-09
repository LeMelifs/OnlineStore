<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container >
      <div class="text-weight-bold text-grey-10 parent q-mt-lg q-mb-sm" style="font-size: 35px;">
        Категории
      </div>
      <div class="text-grey-6 parent q-mb-sm" style="font-size: 15px; text-align: center">
        Эксклюзивная одежда с котиками: стиль, удобство и невероятная милота в каждой вещи.<br> Обновите свой гардероб пушистыми трендами прямо сейчас!
      </div>
      <div class="parent q-mt-lg q-mb-xl">
        <q-btn
          v-for="(button, index) in buttons"
          :key="index"
          :class="{ 'active': activeButton === index }"
          @click="setActiveButton(index)"
          rounded
          flat
          class="text-weight-bold q-py-sm q-px-md"
          style="border: 1.5px solid #3a3a3a; font-size: 13px"
          :style="{ 'margin-right': '8px', ...activeButton === index ? activeButtonStyle : {} }"
        >
          {{ button }}
        </q-btn>
      </div>
      <div class="row parent" >
        <div style="width: 20%; height: 300px" class="q-mx-sm">
          <div class="bg-brown-2 q-mx-md q-mr-sm q-pa-xl parent" style="border-radius: 15px">
            <q-icon size="180px" color="dark" name="mood" />
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-md" style="margin-left: 21px">
            Футболка смайл фэйс
          </div>
          <div class="text-grey-6  q-mt-xs" style="margin-left: 21px">
            Удобная футболка вообще темка вещь
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-xs" style="margin-left: 21px">
            150 ₽
          </div>
        </div>
        <div style="width: 20%; height: 300px" class="q-mx-sm">
          <div class="bg-brown-2 q-ml-md q-mr-sm q-pa-xl parent" style="border-radius: 15px">
            <q-icon size="180px" color="dark" name="mood" />
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-md" style="margin-left: 21px">
            Футболка смайл фэйс
          </div>
          <div class="text-grey-6  q-mt-xs" style="margin-left: 21px">
            Удобная футболка вообще темка вещь
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-xs" style="margin-left: 21px">
            150 ₽
          </div>
        </div>
        <div style="width: 20%; height: 300px" class="q-mx-sm">
          <div class="bg-brown-2 q-ml-md q-mr-sm q-pa-xl parent" style="border-radius: 15px">
            <q-icon size="180px" color="dark" name="mood" />
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-md" style="margin-left: 21px">
            Футболка смайл фэйс
          </div>
          <div class="text-grey-6  q-mt-xs" style="margin-left: 21px">
            Удобная футболка вообще темка вещь
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-xs" style="margin-left: 21px">
            150 ₽
          </div>
        </div>
        <div style="width: 20%; height: 300px" class="q-mx-sm">
          <div class="bg-brown-2 q-ml-md q-mr-sm q-pa-xl parent" style="border-radius: 15px">
            <q-icon size="180px" color="dark" name="mood" />
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-md" style="margin-left: 21px">
            Футболка смайл фэйс
          </div>
          <div class="text-grey-6  q-mt-xs" style="margin-left: 21px">
            Удобная футболка вообще темка вещь
          </div>
          <div class="text-weight-bold text-grey-10 text-h6 q-mt-xs" style="margin-left: 21px">
            150 ₽
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
.q-btn[disabled] {
  background-color: #ffffff;
  color: #3a3a3a;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue"
</script>

<script>
export default {
  data() {
    return {
      buttons: ['Футболки', 'Толстовки', 'Штаны', 'Носки', 'Сумки', 'Аксессуары'],
      activeButton: 0,
      activeButtonStyle: {
        border: '1.5px solid #3a3a3a',
        backgroundColor: '#343434',
        color: 'white'
      }
    };
  },
  methods: {
    setActiveButton(index) {
      this.activeButton = index;
    }
  }
};
</script>
