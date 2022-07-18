<template>
    <div class="md:w-11/12 lg:w-10/12 xl:w-9/12 2xl:w-8/12 mx-auto md:p-5">
        <div class=" text-center md:mb-10 my-5 p-5">
            <div class="flex justify-end">
                <img :src="flag[locale]" @click="switchLocale" class="rounded-full border-2 border-gray-300 p-0.5 w-10 h-10 mb-3"/>
            </div>
            <h1 class="text-lg md:text-xl font-bold">
                <span v-if="locale == 'fr'">
                    Estimation d'application web
                </span>
                <span v-else>
                    Estimate your Web application
                </span>
            </h1>
            <h2 class="mt-3 text-md md:text-lg">
                <span v-if="locale == 'fr'">
                    Combien coûte une application web ? Combien de temps ça prend pour developper une application web ?
                </span>
                <span v-else>
                    How much does a web application cost ? How much time does it take to develop a web application ?
                </span>
            </h2>
        </div>

        <div v-if="error.apiError"  class="mx-2 flex flex-col justify-center items-center py-24 md:py-32 p-10 rounded bg-gray-200 text-center text-red-500">
            <div class="mb-3">
                Oups, {{error.text}}
            </div>
            <img :src="error.image" />
        </div>
        <div v-else>
            <div
                v-if="isLoading"
                class="flex flex-col justify-center items-center text-center w-full py-24 md:py-32 rounded animate-pulse bg-gray-200"
                >
                <div class="mb-3">
                    Loading..
                </div>

                <img class="h-10 w-auto block animate-spin" src="https://img.icons8.com/fluency/48/000000/loading.png"/>
            </div>
            <!-- Error div -->
            <div v-if="!isLoading && questionaire">
                <form v-if="questionaire.length > 0" id="estimationForm">
                    <!--  -->
                    <!-- <div>Web</div> -->
                    <!-- Section pour une question -->
                    <section
                        class="mb-5 bg-green-500 md:rounded p-2 sm:p-5 md:p-10 shadow text-center"
                        >
                        <div class=" bg-white rounded p-2 sm:p-5 lg:p-10 mb-5"
                            v-for="question in questionaire" :key="question.name">

                            <div class="mb-5 text-lg md:text-xl font-semibold">
                                {{locale == 'fr' ? question.title_fr : question.title}}
                            </div>

                            <div class="grid gap-5 grid-cols-3" :class="[question.answers.length >= 4 ? 'md:grid-cols-4': '']">
                                <div
                                    class="rounded cursor-pointer md:p-1 lg:p-2 md:hover:bg-gray-100"
                                    v-for="answer in question.answers" :key="answer.value">
                                    <input
                                        class="hidden_input"
                                        @change="onChange(question.name, question.type, answer.value)"
                                        :id="answer.value"
                                        :type="question.type"
                                        :name="question.name"
                                        :value="answer.value"
                                    />
                                        <!-- v-model="question.type == 'checkbox' ? input[question.name][answer.value] : input[question.name]" -->

                                    <label
                                        class="h-full flex flex-col justify-between items-center cursor-pointer rounded-md"
                                        :for="answer.value">
                                        <div class="hidden md:block rounded p-0.5 px-1 mb-3 text-md md:text-lg">
                                            {{locale == 'fr' ? answer.title_fr : answer.title}}
                                        </div>

                                        <div class="input_image p-1 md:p-2 rounded-full">
                                            <img
                                                class="rounded-full w-full h-auto block"
                                            :src="answer.image" :alt="locale == 'fr' ? answer.title_fr : answer.title" />
                                        </div>

                                        <div class="input_text md:hidden rounded p-0.5 px-1 mt-2 text-xs md:text-md">
                                            {{locale == 'fr' ? answer.title_fr : answer.title}}
                                        </div>

                                    </label>
                                </div>
                            </div>
                        </div>
                    </section>
                    <!-- Results -->
                    <section class="md:mx-0 mx-2 mb-10 p-5 rounded bg-gray-100 ">
                        <!--  -->
                        <div class="md:w-11/12 lg:w-10/12 xl:w-9/12 2xl:w-8/12 mx-auto flex flex-col md:items-end ">
                            <div class="">
                                <div>

                                </div>
                                <div class="text-lg sm:text-xl md:text-2xl font-semibold flex justify-between md:justify-end items-end w-full  ">
                                    <span class="mr-5 flex items-center">
                                        <img :src="flag[locale]" @click="switchLocale" class="rounded-sm border-2 border-gray-300 p-0.5 w-10 h-6 mr-3"/>
                                        Total:
                                    </span>
                                        <!-- <div v-if="isTotalLoading" class="ml-2 animate-pulse w-1/4 h-5 md:h-8 rounded bg-gray-500"></div> -->
                                        <div class=" flex items-center">
                                            <div class="font-bold">
                                                <!-- {{total.price}} {{total.currency}} -->
                                                {{formatted_amount}}
                                            </div>
                                        </div>
                                </div>
                            </div>
                            <div class="text-md mt-2 font-medium flex justify-end md:justify-start text-gray-600 items-end ">
                                <!-- <div v-if="isTotalLoading" class="flex flex-col items-end mt-2 md:mt-3">
                                    <div class="animate-pulse mb-2 w-44  md:w-52 h-8 rounded bg-gray-400"></div>
                                    <div class="animate-pulse w-36 md:w-44 h-4 rounded bg-gray-300"></div>
                                </div> -->

                                <div v-if="total.price > 0" class="flex flex-col items-end">
                                    <div v-if="total.days.designer > 0" class="font-bold md:block flex flex-col items-end">
                                        {{days('designer')}}

                                        <span v-if="weeks('designer')" class="text-sm text-gray-400">
                                            {{weeks('designer')}}
                                        </span>
                                    </div>
                                    <div v-if="total.days.developer > 0" class="font-bold md:block flex flex-col items-end">
                                        {{days()}}
                                        <!--  -->
                                        <span v-if="weeks()"
                                            class="text-sm text-gray-400" >
                                            {{weeks()}}
                                        </span>
                                    </div>
                                    <div class="font-bold text-md md:block flex  items-end">
                                        <span>
                                            <!-- {{total.days.total}} -->
                                            {{total.days.tweenedTotal.toFixed(0)}}
                                            {{locale == 'fr'? "Jours en total": "Days in total"}}
                                        </span>

                                        <span v-if="weeks('total')"
                                            class="ml-2 text-sm text-gray-400" >
                                            {{weeks('total')}}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </form>
                <div v-else class="mx-2 flex flex-col justify-center items-center py-32 p-10 rounded bg-gray-200 text-center text-gray-700">
                    <div>
                        <span v-if="locale == 'fr'">
                            -- Wow, si vide --
                        </span>
                        <span v-else>
                            -- Wow, such empty --
                        </span>
                    </div>
                    <div class="mt-3 text-gray-300 text-sm">
                        <span v-if="locale == 'fr'">
                            Repassez plus tard pour les mises à jour
                        </span>
                        <span v-else>
                            Come back soon for updates
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import gsap from 'gsap'

export default {
    props: ['locale'],
    data() {
        return {
            dev: true,
            // dev: false,
            apiKey: 'AmaneHosanna',
            flag: {
                fr: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_C%C3%B4te_d%27Ivoire.svg/400px-Flag_of_C%C3%B4te_d%27Ivoire.svg.png",
                en: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1600px-Flag_of_the_United_States.svg.png",
            },
            lang: {
                ci: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_C%C3%B4te_d%27Ivoire.svg/400px-Flag_of_C%C3%B4te_d%27Ivoire.svg.png",
                usa: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1600px-Flag_of_the_United_States.svg.png",
            },
            isLoading: true,
            isTotalLoading: false,
            // questions data
            questionaire: [],
            // internal settings
            settings: {},
            error: {
                apiError: false,
                text: this.locale == 'fr' ? "Petit souci" : "Something went wrong",
                image: "https://img.icons8.com/color/48/000000/error--v1.png",
            },
            // enregistrer les choix utilisateur
            input: {
                //
                // checkbox
                // question: [
                //     // answername : true
                // ]
                // question: reponse // radio
            },
            // total
            total: {
                price: 0,
                tweenedPrice: 0,
                currency: 'Fcfa',
                days: {
                    developer: 0,
                    tweenedDeveloper: 0,
                    designer: 0,
                    tweenedDesigner: 0,
                    total: 0,
                    tweenedTotal: 0,
                }
            }

        };
    },
    mounted() {
        if(!this.locale){
            this.locale = 'fr';
        }
        if(this.dev){
            console.log("!! mounted !!", this.locale);
        }

    },
    watch: {
        'total.price': function(newVal){
            if(this.dev){
                console.log(">> tweened price", this.total.tweenedPrice, newVal);
            }
            gsap.to(this.$data.total, {
                duration: 1,
                ease: 'circ.out',
                tweenedPrice : newVal,
            });
        },
        'total.days.developer': function(newVal){
            if(this.dev){
                console.log(">> tweened price", this.total.days.tweenedDeveloper, newVal);
            }
            gsap.to(this.$data.total.days, {
                duration: 1,
                ease: 'circ.out',
                tweenedDeveloper : newVal,
            });
        },
        'total.days.designer': function(newVal){
            if(this.dev){
                console.log(">> tweened designer", this.total.days.tweenedDesigner, newVal);
            }
            gsap.to(this.$data.total.days, {
                duration: .7,
                ease: 'circ.out',
                tweenedDesigner : newVal,
            });
        },
        'total.days.total': function(newVal){
            if(this.dev){
                console.log(">> tweened total", this.total.days.tweenedTotal, newVal);
            }
            gsap.to(this.$data.total.days, {
                duration: .7,
                ease: 'circ.out',
                tweenedTotal : newVal,
            });
        },
    },
    computed:{
        settingsNotValid: function(){

            var isValid = !this.questionaire || (!this.settings.developer_day || !this.settings.designer_day || !this.settings.ui_field_name || !this.settings.currency || !this.locale);

            if(this.dev){
                console.log("== settings", this.questionaire.length, this.settings.developer_day, this.settings.designer_day, this.settings.ui_field_name);

                console.log(">> settingsNotValid", isValid);
            }
            return isValid;
        },
        currency: function(){
            var c = "";
            c = this.locale == 'fr' ? this.settings.currency_fr : this.settings.currency;
            return c;
        },
        formatted_amount: function(){
            try{

                var formatter = new Intl.NumberFormat(this.locale == 'fr' ? 'fr-FR' : 'en-US', {
                style: 'currency',
                currency: this.currency,

                // These options are needed to round to whole numbers if that's what you want.
                //minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
                //maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
                });

                // return formatter.format(this.total.price);
                return formatter.format(this.total.tweenedPrice);
            }catch(err){
                if(this.dev){
                    console.log(">> formatt err");
                    this.error.apiError = true;
                    //    this.error.text = "Som"
                }
            }
        },
        designer_day: function(){
            var c = 16000;
            c = this.locale == 'fr' ? this.settings.designer_day_fr : this.settings.designer_day;
            return parseInt(c);
        },
        developer_day: function(){
            var c = 24000;
            c = this.locale == 'fr' ? this.settings.developer_day_fr : this.settings.developer_day;
            return parseInt(c);
        },
        // developerWeeks: function(){
        //     var weeks = false;
        //     if(this.total.days.developer / 5 > 0){
        //         weeks = (this.total.days.developer / 5 ).toFixed(1);
        //         // is even no floating point
        //         weeks = weeks % 1 == 0 ? weeks | 0 : weeks;

        //     }
        //     if(this.locale == 'fr')
        //         return weeks ? ` (${weeks} semaine${weeks>1?'s':''})` : weeks;
        //     return weeks ? ` (${weeks} week${weeks>1?'s':''})` : weeks;
        // }
    },
    created() {
        if(this.dev){
            console.log("!! App built !!");
        }
        // api fetch questionaire
        // check for cache data
        // this.initAppFromCache();
        // api init app
        this.initApp();
    },

    methods: {
        switchLocale: function(){
            this.locale = this.locale == 'fr' ? 'en' : 'fr';
            this.updateTotal();
        },
        days: function(type = 'developer'){

            type = 'tweened'+type[0].toUpperCase()+type.substring(1);


            var days = this.total.days[type].toFixed(0);
            var s = days>1?'s':'';
            var text = '';
            var text = this.locale == 'fr' ? `jour${s} de developpement` : `developer day${s}`;

            if(type == 'designer'){
                var text = this.locale == 'fr' ? `jour${s} de design` : `designer day${s}`;
            }
            if(type == 'tweenedDesigner'){
                var text = this.locale == 'fr' ? `jour${s} de design` : `designer day${s}`;
            }

            return `${days} ${text}`;
        },
        weeks: function(type = 'developer'){
            type = 'tweened'+type[0].toUpperCase()+type.substring(1);

            var weeks = false;

            if(this.total.days[type] / 5 > 0){
                weeks = (this.total.days[type] / 5 ).toFixed(1);
                // is even no floating point
                weeks = weeks % 1 == 0 ? weeks | 0 : weeks;
            }

            if(this.locale == 'fr')
                return weeks ? ` (${weeks} semaine${weeks>1?'s':''})` : weeks;
            return weeks ? ` (${weeks} week${weeks>1?'s':''})` : weeks;
        },
        onChange(questionName, questionType, answer){
            if(!this.dev){
                console.clear();
                console.log("*** written by amane.dev ***");
                console.log("** inspired by https://estimatemyapp.com/ **");
            }
            //
            if(this.dev){
                console.log(">> onChange", questionName, answer);
                //
                console.log(">> input", this.input);
                console.log(">> input for question", this.input[questionName]);
            }
            // ! this.input[questionName] = {};
            if(questionType == "radio"){
                this.input[questionName] = answer;
            }else{
                // case checkbox
                // trouver l'index
                if(this.input[questionName][answer]){
                    // set inverse for when element exists
                    this.input[questionName][answer] = !this.input[questionName][answer];
                }else{
                    // set true for thirst click
                    this.input[questionName][answer] = true;
                }
            }
            if(this.dev){
                console.log(">> changeUpdated", questionName, answer);
                //
                console.log(">> input", this.input);
                console.log(">> input for question", this.input[questionName]);
            }

            // this.fetchTotal();
            this.updateTotal();
        },
        async initAppFromCache(){
            if(this.dev){
                console.log(">> initAppFromCache");
            }
            if(localStorage.appData){
                try{
                    var appData = JSON.parse(localStorage.appData);
                    this.questionaire = appData.questionaire;
                    this.settings = appData.settings;

                    if(this.dev){
                        console.log("<< q", this.questionaire.length);
                        console.log("<< s", this.settings.length);
                    }


                    if(this.settingsNotValid()){
                        throw "Exception: invalid_settings";
                    }

                    this.setupInput();
                    this.updateTotal();
                    this.isLoading = false;
                }catch(parseError){
                    if(this.dev){
                        console.log("xx parseError >>", parseError);
                    }
                    this.initApp();
                }
                return;
            }
        },
        // fetches the questions from the api but also the settings
        async initApp() {
            //
            if(this.dev){
                console.log(">> initApp");
            }
            try{
                // Get cached questions first

                // Setup input
                const response = await fetch("/data/questionaire?apikey="+this.apiKey);
                if(this.dev){
                    console.log("<< r", response.status, response);
                }
                if (response.status !== 200) {
                    this.error.apiError = true;
                    //
                    if(response.status >= 300){
                        this.error.text = "Too many redirects"
                    }
                    if(response.status >= 400){
                        this.error.text = "Something happened"
                    }
                    if(response.status >= 500){
                        this.error.text = "Could not connect to amane.dev"
                        this.error.image = "https://img.icons8.com/external-flatart-icons-flat-flatarticons/64/000000/external-error-user-interface-flatart-icons-flat-flatarticons-1.png"
                    }
                        //
                    return;
                }

                // Process response data
                const data = await response.json();
                if(this.dev){
                    console.log("<< d", data);
                }
                if(data){

                    if(data['error']){
                        this.error.apiError = true;
                        if(data['message']){
                            this.error.text = data['message'];
                        }
                        return;
                    }
                    localStorage.appData = null;
                    this.questionaire = data['questionaire'];
                    this.settings = data['settings'];
                    // cache questionaire and settings
                    var appData = JSON.stringify(data);
                    localStorage.appData = appData;
                    if(this.dev){
                        console.log("<< ap");
                        console.log(this.settings);
                    }
                    // Init input values
                    this.setupInput();
                }
                    this.isLoading = false;
                }catch(er){
                    if(this.dev){
                        console.log("xx fetch er", er)
                    }
                    this.error.apiError = true;
                }
            },
            setupInput(){
                if(this.dev){
                    console.log(">> setupInput");
                }
                if(this.questionaire){
                    this.questionaire.forEach(question => {
                        // si checkbox
                        // init question to empty
                        this.input[question.name] = {};
                        if(question.type == 'checkbox'){
                        // pour chaque réponse
                            question.answers.forEach(reponse =>{
                                // initialiser la valeur réponse à false
                                this.input[question.name][reponse.value] = false;
                            });
                        }else{
                            // init le nom de la question à null
                            this.input[question.name] = null;
                        }
                    });
                    //
                    if(this.dev){
                        console.log("<< i");
                    }
                    // Save data to localstorage
                    // var jsonInput = JSON.stringify(this.input);
                    // localStorage.input = jsonInput;
                }
            },
            //
            async updateTotal(){
                this.isTotalLoading = true;
                this.total.days.developer = 0;
                this.total.days.designer = 0;
                // ? ** Maagic */
                    // ! Don't temper with the spell, Peter !
                    if(this.questionaire){
                        if(this.input){
                            //
                            Object.entries(this.input).forEach(([questionName, answerData])=> {
                                //
                                var $days = 0;
                                // const answerData = this.input[questionName];
                                // find question
                                const question = this.questionaire.find(q => q.name === questionName);
                                if(question){
                                    // get question type
                                    if(question.type === "radio"){
                                        // take answerData literally
                                        // find the right answer
                                        // don't calculate ui questions
                                        if(questionName !== this.settings.ui_field_name){
                                            // we're gonna calculate designer days based on that
                                            const answer = question.answers.find(a => a.value === answerData);
                                            if(answer){
                                                // get the days
                                                $days = parseInt(answer.content);
                                            }
                                        }
                                    }else{
                                        // type checkbox
                                        // run each answer data
                                        Object.entries(answerData).forEach(([answerValue, isChecked]) => {
                                            // find the answer
                                            const answer = question.answers.find(a => a.value === answerValue);
                                            if(answer){
                                                // update days if value is true
                                                if(isChecked){
                                                    $days += parseInt(answer.content);
                                                }
                                            }
                                        })
                                    }
                                }
                                // update total
                                // TODO : calc price too
                                this.total.days.developer += parseInt($days);
                            });
                            //
                            // find ui design percentage
                            var ui_field = this.settings.ui_field_name;
                            var ui_value = this.input[ui_field];


                            if(ui_value){
                                var percentage = 0;

                                try{
                                    // find question
                                    const question = this.questionaire.find(q => q.name === ui_field);
                                    // find answer
                                    const answer = question.answers.find(a => a.value === ui_value);
                                    // find percentage value
                                    const ratio = answer.content;

                                    percentage = parseInt(ratio)/100;
                                    if(this.dev){
                                        console.log(">> ratio percent", ratio, percentage);
                                    }
                                }catch(conversionError){
                                    // could not convert
                                    if(this.dev){
                                        console.log("xxx conversionError");
                                    }
                                }

                                var designer_days = this.total.days.developer * percentage;

                                // calculate designer days from developer days
                                this.total.days.designer = Math.floor(designer_days);
                            }
                            // update total days
                            // this.total.days.total = this.total.days.designer + this.total.days.developer;
                            // // calculate final price
                            // this.total.price = this.total.days.designer * this.settings.designer_day + this.total.days.developer * this.settings.developer_day;
                            // this.total.currency = this.settings.currency;

                            /** Updates */
                            this.total.days.total = this.total.days.designer + this.total.days.developer;
                            // calculate final price
                            if(this.dev){
                                console.log("rates: ", this.designer_day, this.developer_day);
                            }
                            this.total.price = this.total.days.designer * this.designer_day + this.total.days.developer * this.developer_day;
                            this.total.currency = this.currency;
                        }
                    }
                // ? ** End Maagic : */
                setTimeout(()=>{
                    this.isTotalLoading = false;
                }, 100);

                if(this.dev){
                    console.log("<<< total", this.total.days.designer, this.total.days.developer, this.total.days.total, this.total.price);
                }
                return this.total;
            },
    }
};
</script>

<style>
    input.hidden_input{
        display: none;
    }
    input.hidden_input:checked + label .input_image{
        background: #6699cc;
    }
    input.hidden_input:checked + label .input_text{
        color: #6699cc;
        font-weight: 700;
        background: #efefef;
    }
</style>
