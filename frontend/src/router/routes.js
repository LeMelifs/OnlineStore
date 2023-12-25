
const routes = [
  {
    path: '/',
    component: () => import('pages/LoginPage.vue')
  },
  {
    path: '/reset',
    component: () => import('pages/ResetPassword.vue')
  },
  {
    path: '/registration',
    component: () => import('pages/RegistrationPage.vue')
  },
  {
    path: "/main",
    component: () => import('pages/MainPage.vue')
  },
  {
    path: "/account",
    component: () => import('pages/AccountPage.vue')
  },
  {
    path: "/bucket",
    component: () => import('pages/BucketPage.vue')
  }
]

export default routes
