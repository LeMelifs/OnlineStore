
const routes = [
  {
    path: '/',
    component: () => import('pages/loginPage.vue')
  },
  {
    path: "/main",
    component: () => import('pages/mainPage.vue')
  }
]

export default routes
