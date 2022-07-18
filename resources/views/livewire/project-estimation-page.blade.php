<div>
    <div id="vue-app">
        <app-estimation-component :locale="{{json_encode($locale)}}"></app-estimation-component>
    </div>
</div>


@section('title', "App price calculator")
@section('meta')
    <meta charset='UTF-8'>
    <meta name='keywords' content='estimation prix projet, devis projet web, quote web application, estimer mon projet'>
    <meta name='description' content="Estimez le prix de votre application web ou mobile">
    <meta name='subject' content="Estimation de prix">
    <meta name='copyright' content="Amane.dev">
    <meta name='language' content="en">
    <meta name='robots' content='index,follow'>
    <meta name='revised' content='Fri, Sep 10th, 2021, 11:17 am'>
    <meta name='abstract' content=''>
    <meta name='topic' content=''>
    <meta name='summary' content=''>
    <meta name='Classification' content='Calculator'>
    <meta name='author' content='amane.dev, hello@amane.dev'>
    <meta name='designer' content=''>
    <meta name='reply-to' content='hello@amane.dev'>
    <meta name='owner' content=''>
    <meta name='url' content='https://www.amane.dev/estimation-de-projet'>
    <meta name='identifier-URL' content='https://www.amane.dev/estimation-de-projet'>
    <meta name='directory' content='submission'>
    <meta name='pagename' content="App price calculator">
    <meta name='category' content=''>
    <meta name='coverage' content='Worldwide'>
    <meta name='distribution' content='Global'>
    <meta name='rating' content='General'>
    <meta name='revisit-after' content='7 days'>
    <meta name='subtitle' content='Project price calculator'>
    <meta name='target' content='all'>
    <meta name='HandheldFriendly' content='True'>
    <meta name='MobileOptimized' content='320'>
    <meta name='date' content='Aug. 31, 2021'>
    {{-- <meta name='search_date' content='2010-09-27'> --}}
    {{-- <meta name='DC.title' content='Unstoppable Robot Ninja'> --}}
    {{-- <meta name='ResourceLoaderDynamicStyles' content=''> --}}
    {{-- <meta name='medium' content='blog'> --}}
    {{-- <meta name='syndication-source' content='https://mashable.com/2008/12/24/free-brand-monitoring-tools/'> --}}
    {{-- <meta name='original-source' content='https://mashable.com/2008/12/24/free-brand-monitoring-tools/'> --}}
    <meta name='verify-v1' content='dV1r/ZJJdDEI++fKJ6iDEl6o+TMNtSu0kv18ONeqM0I='>
    {{-- <meta name='y_key' content='1e39c508e0d87750'> --}}
    {{-- <meta name='pageKey' content='guest-home'> --}}
    {{-- <meta itemprop='name' content='jQTouch'> --}}
    {{-- <meta http-equiv='Expires' content='0'> --}}
    {{-- <meta http-equiv='Pragma' content='no-cache'>
    <meta http-equiv='Cache-Control' content='no-cache'>
    <meta http-equiv='imagetoolbar' content='no'>
    <meta http-equiv='x-dns-prefetch-control' content='off'> --}}


    <meta name="og:title" content="Amane.dev"/>
    <meta name="og:type" content="Site web"/>
    <meta name="og:url" content="{{env('APP_URL')}}">
    <meta name="og:image" content="{{asset(env('APP_ICON_URL'))}}"/>
    <meta name="og:site_name" content="Amane.dev"/>
    <meta name="og:description" content="Calculer le prix de votre application web ou mobile"/>
@endsection
