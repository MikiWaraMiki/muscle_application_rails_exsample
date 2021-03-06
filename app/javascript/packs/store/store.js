import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import request from '../utils/request.js'

Vue.use(Vuex)
const initialState = {
    loggedIn: false,
}
const getters = {
    getLoginStatus: state=> {
        return state.loggedIn
    }
}
export default new Vuex.Store({
    state: initialState,
    getters: getters,
    mutations: {
        login(state, header, body){
            // localstorageに次回操作に必要なheader情報を格納
            localStorage.setItem('Client', header['client'])
            localStorage.setItem('Token', header['access-token'])
            localStorage.setItem('Expiry',header['expiry'])
            localStorage.setItem('Uid', header['uid'])
            localStorage.setItem('TokenType',header['token-type'])
            state.loggedIn = true;
        },
        logout(state, token){
            localStorage.clear()
            state.loggedIn = false;
        }
    },
    actions: {
        signup( {commit}, payload) {
            const options = {
                params: {
                    name: payload.payload.name,
                    email: payload.payload.email,
                    password: payload.payload.password,
                    password_confirmation: payload.payload.password_confirmation
                }
            };
            request.post('/api/v1/auth', options).then( (response) => {
                // 登録が完了したらトークンを発行
                commit('login', response.headers,response.body)
                payload.router.push('/user')
            }, (error) => {
                console.log("登録が失敗")
            });
        },
        login( {commit}, payload) {
            const options = {
                params: {
                    email: payload.payload.email,
                    password: payload.payload.password
                }
            };
            request.post('/api/v1/auth/sign_in', options).then( (response) => {
                commit('login', response.headers);
                //indexへ遷移
                payload.router.push('/user');
            }, (error) => {
                console.log("ログインに失敗");
            });
        },
        logout( {commit}, payload){
            request.delete('/api/v1/auth/sign_out', { auth: true}).then( (response) => {
                commit('logout');
                 // indexへリダイレクト
                payload.router.push('/')
            }, (error) => {
                console.log("ログアウトに失敗");
            });
        }
    }

})