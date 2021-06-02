//
//  plant.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import Foundation
struct Plant {
    var 이름: String
    var 원산지 : String
    var 과명: String
    
    var 생육온도 : String
    var 광요구도 : String
    var 물주기 : String
    
    var 특징 : String
    
    var 한줄설명 : String

}


var plantsClearAir: [Plant] = [
    Plant(이름: "홍콩야자", 원산지: "중국,대만",과명: "두릅나무과",생육온도: "20-25도", 광요구도: "어떤 광도나 무난(300~10,000 Lux)하여 실내 어두운 곳, 거실 또는 발코니에서 키우기 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "실내공기정화력이 우수한, 특히 담배연기를 잘 흡수하는 식물로 알려져 있으며 키가 큰 종류의 쉐플레라(야자)와 키가 작은 왜성종 쉐플레라가 있음.\n\n물 꽂이 화분에 심어도 뿌리가 내리는 적응력이 강한 식물이지만, 추위에는 약함. \n\n수건으로 잎을 닦아 주면 잎에서 윤기가 생겨 관상하기 좋음.", 한줄설명: "  대표 공기정화 식물"),
    Plant(이름: "관음죽", 원산지: "한국,일본,중국남부",과명: "야자과",생육온도: "16-20도", 광요구도: "낮은 광도(300~800 Lux),중간 광도(800~1,500 Lux),높은 광도(1,500~10,000 Lux)", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "손바닥 모양의 잎을 가진 집에서 기르기 쉽고 그늘과 추위에도 잘 견디고 병해충에도 강하기기 때문에 기르기 쉬운 식물임.\n\n자라는 속도가 느려서 관리가 편함. 반엽이 들어있는 종은 색상이 더욱 아름다움. 2년에 한 번씩 분갈이를 해 주면 좋음.", 한줄설명: "  음지에서 잘자라요"),
    Plant(이름: "대나무야자", 원산지: "멕시코, 중앙아메리카",과명: "야자과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 발코니에서 키우는 것이 좋음", 물주기: "토양 표면이 말랐을때 충분히 관수함", 특징: "최대 2m 정도 자라며 모양이 가늘고 호리호리한 줄기들이 모여 하나의 다발을 이루는 형태를 가짐. \n\n주황빛을 띄는 줄기에 검은색의 열매가 맺히지만 독성이 있으므로 먹지 않는 것이 좋음. \n\n생장이 매우 빠른편으로 반양지에서 직사광선을 피하여 기르는 것이 좋지만 광량이 너무 적으면 잎이 전체적으로 처지고 모양이 흐트러짐. \n\n물은 흠뻑 주며 하루에 한 두 차례 엽면에 스프레이로 뿌려 줄 경우 외관을 유지하는데 도움이 됨.", 한줄설명: "  실내정화식물 탑"),
    Plant(이름: "파키라", 원산지: "중앙아메리카",과명: "물밤나무과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니 내측에서 키우기는 것이 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "외국에서는 Money tree라고 불리우고, 잎과 꽃은 채소처럼 식용하고, 열매는 땅콩맛이 난다.\n\n공기 정화 식물로 잘 알려져 있다. 손가락같이 갈라진 잎과 뿌리 윗부분의 줄기가 통통한 모양새가 특이한 이국적인 식물이다.", 한줄설명: "  초보자도 잘키워요"),
    Plant(이름: "황금죽", 원산지: "카메룬",과명: "백합과",생육온도: "16-20도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니 내측에서 키우기는 것이 좋음", 물주기: "토양 표면이 말랐을때 충분히 관수함", 특징: "하늘에서 황금을 내려준다라는 부를 상징하는 꽃말을 가짐. \n\n사무기기에서 발생하는 휘발성 화학물질 제거 능력이 뛰어남. 공기정화 및 습도 조절이 탁월함\n\n여름철 직사광선은 잎끝을 까맣게 타게 할 수 있기 때문에 피하는 것이 좋음. 추위에 매우 약하기 때문에 온도조절이 필수적임.", 한줄설명: "  하늘에서 황금이"),
    Plant(이름: "산세베리아", 원산지: "남아프리카",과명: "백합과",생육온도: "21-25도", 광요구도: "어떤 광도나 무난(300~10,000 Lux)하여 실내 어두운 곳, 거실 또는 발코니에서 키우기 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "산세베리아는 이탈리아 산 세베로의 왕자 라이문도 디 산그로를 기리기 위해 붙인 이름이다. \n\n개나 고양이와 같은 애완동물이 섭취했을 경우는 구토나 설사를 일으킬 수 있으므로 조심해야 한다. \n\n실내에서 꽃 피기는 상당히 어렵지만, 환경이 좋으면 흰빛에 가까운 옅은 그린색의 작은 꽃들이 핀다. \n\n과습하지 않더라도 실내 온도가 10°C 이하인 경우 썩는 원인이 된다.", 한줄설명: "  개나 고양이는 조심")
  
]
var plantsShade: [Plant] = [
    Plant(이름: "스킨답서스", 원산지: "솔로몬군도, 인도네시아",과명: "천남성과",생육온도: "21-25도", 광요구도: "어떤 광도나 무난(300~10,000 Lux)하여 실내 어두운 곳, 거실 또는 발코니에서 키우기 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "에코플렌트 중에서 가장 관리가 쉽고 잘 자라는 식물로 병해충에 대한 강한 저항성을 갖고 있다. \n\n실내관엽 식물중 일산화탄소 제거능이 우수하여 주방의 기능성 식물로 알려진 종으로 어두운 곳에서도 잘 적응한다. \n\n약 40m 길이까지 자랄 수 있는 덩굴성으로 행잉으로 이용하며 기근을 갖는다. \n\n칼슘옥살레이트 성분을 가지고 있어 애완동물에게는 독성이 있다. ", 한줄설명: "  일산화탄소 제거"),
    Plant(이름: "아이비", 원산지: "유럽,서아시아,북아프리카",과명: "두릅나무과",생육온도: "16-20", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니에서 키우는 것이 좋음", 물주기: "봄, 여름, 가을에는 흙을 촉촉하게 유지하고 겨울에는 토양 표면이 말랐을때 충분히 관수함", 특징: "아이비는 더운 것을 싫어하므로 너무 더운 곳은 피하고 조금 서늘한 곳에서 키우는 것이 좋다. 주위가 건조할 때는 잎에 자주 분무해 준다.", 한줄설명: "  덩굴로 조형 즐기기"),
    Plant(이름: "싱고니움", 원산지: "열대아메리카",과명: "천남성과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우기는 것이 좋음", 물주기: "봄, 여름,가을에는 토양 표면이 말랐을때 충분히 관수하며 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "연두색, 흰색, 빨강, 분홍색등의 잎색과 줄무늬, 점무늬 등 다양한 잎모양을 지닌 대표적인 잎보기식물이다. \n\n실내 암모니아 제거능력 우수하고 반그늘을 좋아하며 고온다습한 환경에서 잘 자란다. \n\n덩굴성이면서 줄기 마디에서 기근이 나와 다른 물체에 붙어 자란다. \n\n줄기를 자르면 즙액이 나오고 이를 식용하면 위험하다. 응애, 깍지벌레, 온실가루이 병충해를 조심한다.", 한줄설명: "  초심자도 쉽게"),
    Plant(이름: "문샤인", 원산지: "남아프리카",과명: "용설란과",생육온도: "15-23도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니 내측에서 키우기는 것이 좋음", 물주기: "물을 주기전에 흙이 마르도록 한 다음 물을 철저히하고 자유롭게 배수. 뿌리가 썩을 수 있으므로 식물을 물에 담그지 말 것", 특징: "달빛처럼 빛나는 모습을 가졌다하여 붙여진 이름이다. 먹으면 약간 독성이 있기때문에 어린이와 동물로 부터 멀리하는 것이 좋다.\n\n습도 조절은 물로 다른 식물에 비해 음이온을 30배 더 배출한다. 또한 공기 중 독서를 필터링하며 청정 공기 식물 수집의 일부이다.", 한줄설명: "  산세베리아 사촌"),
    Plant(이름: "파비안느", 원산지: "뉴칼레도니아",과명: "두릅나무과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니 내측에서 키우기는 것이 좋음", 물주기: "봄, 여름,가을에는 토양 표면이 말랐을때 충분히 관수하며 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "원래 이름은 무늬 둥근잎아랄리아. \n\n아세톤 및 알코올 분해가 뛰어나 나사에서 선정한 공기정화 식물 중 10위에 선정되었을 뿐 아니라 가습 효과가 있다.\n\n가지가 많이 갈라지고 원산지에서는 10m 가까이 자라는 나무이며, 화분에서 수직으로 자라기 때문에 좁은 공간에서 활용하기 좋다.", 한줄설명: "  동글한 잎이 귀여운"),
    Plant(이름: "스파티필름", 원산지: "콜롬비아, 베네수엘라",과명: "천남성과",생육온도: "21-25도", 광요구도: "낮은 광도(300~800 Lux),중간 광도(800~1,500 Lux),높은 광도(1,500~10,000 Lux)", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "나사의 공기정화식물 실험을 거친 원예종으로 유해물질의 제거 능력이 특히 매우 뛰어나 공기정화식물로도 인기가 많다. \n\n꽃자루가 길고 흰색의 아름다운 포엽에 꼬리같은 육수화서가 붙어있다. \n\n공기정화식물로도 유명하지만, 칼라를 닮은 포엽이 완전히 전개되면 우아한 꽃과 같은 느낌이다. 흰색의 포엽은 시간이 지날수록 녹색으로 바뀌어 간다. \n\n공중습도 관리에 유의하며 습한 여름철을 제외하고 잎에 자주 분무한다.", 한줄설명: "  싱그러움 그 자체")
  
]
var plantsDry: [Plant] = [
    Plant(이름: "정야", 원산지: "멕시코",과명: "돌나물과",생육온도: "5-30도", 광요구도: "충분한 광 요구", 물주기: "한 달에 한 번 전체적으로 관수, 여름 장마철에 과습하지 않게 관리", 특징: "식물체 지름이 5cm정도이고 녹색 빛이 나는 흰색의 둥근잎이 촘촘히 겹쳐난다. \n\n외줄기이며, 나중에는 줄기가 길어지며 로제트의 직경은 6cm 정도이다. \n\n물을 극히 아껴야 웃자람이 덜 하며 점차 잎이 조금씩 커지고 벌어지면서 전체적인 부피감이 커진다. \n\n연한 청록색의 잎에 백분이 있으며, 빛을 충분히 받으면 잎 가장자리가 옅은 주황색으로 물든다.", 한줄설명: "  장미 모양이 특징"),
    Plant(이름: "만세선인장", 원산지: "플로리다, 카리브해",과명: "선인장과",생육온도: "20도 이상", 광요구도: "충분한 광 요구", 물주기: "흙을 푹 찔러 넣었을때 젖은 흙이 묻어나오지 않는다면 물을 줌. 주기는 가정 환경에 따라 한달 혹은 두달 정도", 특징: "원래 이름은 로드킬 선인장. \n\n전자파 차단에 효과가 있어 해가 잘 드는 거실 전자기기 옆이나 컴퓨터 방등에 두기 좋은 식물이다. \n\n그 외에도 음이온을 방출하고 낮에는 이산화 탄소를 흡수하고 밤에는 산소를 배출하여 공지 정화능력도 탁월하다.\n\n잎이 쭈글쭈글 해 지는 시기가 있다. 쭈글거리는 원인이 뿌리에서 수분부족으로 물을 빨아 들이기 위함으로 이때 충분히 물을 주자.", 한줄설명: "  누가봐도 선인장"),
    Plant(이름: "백도선",원산지: "멕시코",과명: "선인장과",생육온도: "24-25도", 광요구도: "충분한 광 요구", 물주기: "전체적으로 쭈글거릴 때 관수한다. 대체로 한달에 한번이면 충분하고 몇달간 물을 주지 않아도 살 수 있다.", 특징: "금오모자선인장의 변종으로 2-mm의 삐죽한 흰색 가시가 많이 나와았다. 잘 자랄 경우 붉은 열매가 열린다.\n\n다른 선인장에 비해 가시가 부드러운 편이며 자구 번식이 활발한데, 자란 자구를 잘라 심으면 새로운 선인장이 된다. \n\n자구 모양으로 토끼 귀 선인장으로 불리며 만지면 흰색 가시가 우수수 떨어진다.", 한줄설명: "  토끼인줄 알았잖아"),
    Plant(이름: "소정", 원산지: "브라질, 우루과이",과명: "선인장과",생육온도: "낮 최고 30-35, 야간 최전 10도", 광요구도: "충분한 광 요구", 물주기: "흙을 푹 찔러 넣었을때 젖은 흙이 묻어나오지 않는다면 물을 줌. 생장기인 봄, 가을에 비해 여름, 겨울은 관수량 및 빈도 줄이기", 특징: "구형에서 원통형 형태로 직경 10cm, 높이 20cm 정도까지 자란다. 단구로 자라다가 커지면 자구가 생기기도 한다. \n\n꽃은 봄에 노란색으로 직경 4cm 정도의 꽃이 피며 다화성이다. 햇빛을 받으면 꽃이 펼쳐졌다 해가 지면 오무라 들며 일주일 정도 반복하며 핀다. ", 한줄설명: "  동글동글 귀여워"),
    Plant(이름: "은행목", 원산지: "남아프리카",과명: "쇠비름과",생육온도: "18-24도", 광요구도: "충분한 광 요구", 물주기: "한달에 세번정도 10일정도 주기를 가짐", 특징: "줄기는 둥근 목질부를 갖추고 분지를 잘 하며 잎은 마주나고 다육질이며 둥글고 길이 12mm 폭 10mm 정도이다.\n\n꽃은 분홍빛이 되는 흰색으로 꽃잎은 둥그스름하며 햇빛을 많이 받으면 잎 가장 자리가 붉은색을 띈다. \n\n잎 가장자리에 흰색 무늬가 있는 풍좀은 무늬 은행목으로 시중에서는 아악무로라고 불린다.", 한줄설명: "  다육이 미모 탑"),
    Plant(이름: "라울", 원산지: "멕시코",과명: "돌나물과",생육온도: "16-20도", 광요구도: "충분환 광 요구", 물주기: "한달에 한번정도 물주기. 다른 다육에 비해 물을 좋아하나 과습에는 주의할 것.", 특징: "어린 라울은 연두빛이 많이 돌지만 점점 시간이 흐르면서 붉은 빛을 띄게 된다. 또한 어린 모종일때는 향기가 나지 않지만 성장을 어느 정도하게 되면 향기가 난다. \n\n라울은 군생을 이루며 잘 자라며 줄기는 목질화가 잘 된다. \n\n에케베리아와 다른 둥글둥글한 잎으로 이루어진 로제트는 귀여운 느낌을 낸다.", 한줄설명: "  국민 다육이")
  
]


var plantsLazy: [Plant] = [
    Plant(이름: "제라늄", 원산지: "남아프리카 원산종의 원예교배종",과명: "쥐손이풀과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우기는 것이 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "꽃이 진 후에 생긴 꼬투리의 모양을 황새에 부리에 비유해서 생긴 이름이다. \n\n유럽이나 아메리카에는 창가에 적색이나 주황색, 흰색꽃을 피우는 제라늄이 화분에 심어져 장식되어 있는 풍경이 눈에 띈다. \n\n제라늄은 잎에 강한 악취가 있으며 품종마다 각각 향기가 조금씩 다르다. \n\n수렴성이 있어 향료 이외에도 이질이나 궤양에도 약효가 있어 약용한다. ", 한줄설명: "  종류가 너무 다양해"),
    Plant(이름: "금전수", 원산지: "아프리카 동부(케냐), 남부",과명: "천남성과",생육온도: "16-20도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니에서 키우는 것이 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "그늘진 곳에서 잘 견디지만, 실내 밝은 간접광이 더 좋다. \n\n환경 조건에 견디는 힘이 뛰어나고 과습한 상태에서 저온상태가 되면 뿌리가 썩기 쉽다. \n\n수분이 많은 지하경을 가지고 광택이 있는 잎이 매력적이다.\n\n금전운과 행운이 깃든다는 의미로 돈나무라는 별칭을 가져 실내 인테리어 뿐 아니라 집들이, 개업, 전시회 등에 선물에 좋다. \n\n또한 가습효과와 전자파를 흡수하는 식물로 사무실이나 침실에 두기 좋다.", 한줄설명: "  돈나무로 선물 추천"),
    Plant(이름: "바이올렛", 원산지: "아프리카",과명: "제스네리아과",생육온도: "16-20도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실이나 발코니에서 키우는 것이 좋음", 물주기: "건조해도 잘 버티지만 꽃을 피우기 위해서는 속흙이 마른 것을 확인하고 물을 주는 것이 좋다. 잎에 물이 닿지 않도록 잎을 들어서 준다.", 특징: "꽃의 색은 흰색, 보라색, 분홍색, 파란색 등으로 매우 다양하다. \n\n열대지방이 원산지로 생육온도를 유지해주면 1년 내내 꽃을 볼 수 있으며 빛이 충분하면 꽃이 피어 오래 지속되나 빛이 부족한 반음지나 음지에서는 꽃이 피지 않는다.\n\n물이 잎이나 꽃에 닿으면 털 때문에 물이 고여 곰팡이병이나 데워질 수 있어 조심해야 한다.", 한줄설명: "  앙증맞은 화려한 꽃"),
    Plant(이름: "뱅갈고무나무", 원산지: "인도, 파키스탄, 스리랑카",과명: "뽕나무과",생육온도: "21-25", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우는 것이 좋음", 물주기: "토양 표면이 말랐을때 충분히 관수함", 특징: "원산지인 인도에서 고무나무는 장수와 풍요의 상징으로 신성 시 여겨진다. \n\n미세먼지를 흡수하고 산소를 배출하는 공기정화 능력이 탁월하며 관리가 쉽고 튼튼한 편이라서 실내에서 키우기에 좋다. \n\n다른 고무나무 종에 비해 연한 녹의 잎을 가지고 있고 연한 노란빛이 섞인 독특한 무늬가 매력적이다.", 한줄설명: "  장수와 풍요의 상징"),
    Plant(이름: "호야", 원산지: "일본, 중국, 오스트레일리아",과명: "박주가리과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우기는 것이 좋음", 물주기: "토양 표면이 말랐을때 충분히 관수함", 특징: "줄기는 기근을 뻗어서 나무나 바위에 부착한다.\n\n잎은 마주나며 타원형으로 광택이 있고 두꺼우며 가장자리가 밋밋하다. \n\n꽃은 늦은 봄에서 여름 사이에 잎겨드랑이에서 꽃대가 자라나 많은 별 모양의 꽃들이 방사형으로 반구형을 이루고 향기가 짙다. \n\n꽃색깔은 백색, 자갈색, 연한 분홍색, 분홍색 등이 있다. ", 한줄설명: "  초보자도 쉽게"),
    Plant(이름: "스투키", 원산지: "아프리카 동부",과명: "백합과",생육온도: "18-27도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우는 것이 좋음", 물주기: "보통 한달에 한번정도 관수하며 겨울에는 두 달에 한번 정도 관수한다.", 특징: "포름 알데히드 등 공기중의 유해 성분을 제거해주는 실내 공기 정화식물 중의 하나이다. \n\n음이온과 피톤치드 효과가 있어서 심신 안정과 스트레스 해소에 도움을 준다는 선인장이다. \n\n직사광선에도 강하고 음지에서도 잘자라 통풍이 잘되는 밝은 집안에서도 잘 자라는 키우기 쉬운 식물이다. \n\n뿌리가 짧고 약해 물관리를 잘 못하며 쉽게 상하여 물을 주지 않는 것이 잘 키우는 방법 중 하나이다.", 한줄설명: "  귀차니즘에게 깅추")
  
]

var plantsInterior: [Plant] = [
    Plant(이름: "코로키아", 원산지: "뉴질랜드",과명: "아르고필룸과",생육온도: "15-25도", 광요구도: "햇빛이 잘드는 양지바른 곳이나 반양지가 적당하나 음지에서도 잘 자란다.", 물주기: "겉흙이 말랐을 때 주는데, 한번에 듬뿍 주는 것보다는 100-150ml정도의 소량을 주는 것이 좋다. 약간 건조하게 관리한다.", 특징: "마른가지가 지그재그 모양으로 서로 얽혀있는 것이 특징이다. \n\n특유의 분위기로 인해 유럽에서 인테리어용으로 사랑받고 있으며, 최근 우리나라에도 인지도가 높아지고 지며 인기가 증가하고 있다.\n\n잎은 겨울엔 은빛이 도는 갈색이지만 , 봄에는 푸르게 변하며 노란 꽃과 열매를 틔운다.", 한줄설명: "  한 폭의 그림같은"),
    Plant(이름: "테이블야자", 원산지: "멕시코 과테말라",과명: "야자과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 실내 어두운 곳, 거실 또는 발코니에서 키우는 것이 좋음", 물주기: "봄, 여름, 가을에는 흙을 촉촉하게 유지하고(물에 잠기지 않도록 주의) 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "공기중에 수분을 방출하는 능력이 뛰어나고 벤젠, 포름알데히드등의 화학물질을 제거하는데 좋아 공기정화식물로도 적절하다. \n\n책상 위에 올려둘 수 있을 만큼 귀여운 크기를 지녀 테이블 야자라고 불리게 되었다. \n\n수경재배도 가능하여 물을 주기 어렵다면 수경재배로도 싱싱한 테이블 야자를 기를 수 있다.\n\n시원한 휴양지 느낌이 나는 식물로 인테리어 용으로 인기가 많다.", 한줄설명: "  공기정화 효과는 덤"),
    Plant(이름: "올리브나무",원산지: "지중해",과명: "물푸레나무과",생육온도: "15-28도", 광요구도: "여름철 직사광선을 피한 양지 또는 반양지", 물주기: "화분 겉흙이 말라갈 때 듬뿍주되 겨울에는 관수량을 줄인다.", 특징: "평균 100년 이상을 살아 수명이 길고 현재까지 몇 천년이 된 것도 존재한다. \n\n자가 수정이 거의 불가능해서 열매를 보려면 2-3가지 다른 품종의 나무를 같이 키우는 것이 좋다.\n\n열매가 올리브기름과 피클을 만드는 데 이용되고, 올리브 나무의 가지는 비둘기와 함계 평화의 상징이다.", 한줄설명: "  평화의 상징"),
    Plant(이름: "몬스테라", 원산지: "멕시코남부, 파나마, 중앙 아메리카(과테말라)",과명: "천남성과",생육온도: "16~20도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우기는 것이 좋음", 물주기: "봄, 여름, 가을에는 흙을 촉촉하게 유지하고(물에 잠기지 않도록 주의) 겨울에는 토양 표면이 말랐을때 충분히 관수함", 특징: "몬스테라는 덩굴성 대형관엽식물로 6~8m 까지 자람. 잎은 어긋나고 성숙한 것은 지름 1m 정도.\n\n잎은 진녹색으로 크고 광택이 나며 잎맥 사이에 군데군데 타원형의 구멍이 파여 있어 폭우나 강한 바람에도 견딜 수 있는 구조로 발달. 흰색의 꽃이 피고 열매도 달림. \n\n직시광선에 노출시키면 잎이 타기 쉬우므로 그늘에 둬야 함. 식물체 는 독성이므로 어린이주변에 두지말 것", 한줄설명: "  한 번쯤은 봤지?"),
    Plant(이름: "유칼립투스", 원산지: "오스트레일리아, 태즈메이니아 남부",과명: "도금양과",생육온도: "18-22도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우기는 것이 좋음", 물주기: "겉흙이 마르면 물을 흠뻠주는데 보통 주 1-2회 관수한다.", 특징: "유칼립투스는 잘 싸였다는 뜻으로 꽃이 피기 전에 꽃받침이 꽃의 내부를 완전히 둘러싸는 것에서 비롯되 이름이다. \n\n조림수종으로 심으며, 목재는 건축재나 기구재로 쓴다. 나무가 자라면서 수분을 많이 흡수하므로 집 근처에 심어서 주변을 건조시키는 데 이용한다.\n\n호흡기 질환과 방부/소독 효과가 뛰어나 의약품이나 화장품 등 여러 분야에서 다양하게 쓰이고 있다.", 한줄설명: "  대표 꽃장식 소품"),
    Plant(이름: "극락조",원산지: "남아프리카",과명: "파초과",생육온도: "18-25도", 광요구도: "실내의 밝은 곳", 물주기: "12-20일 사이 1회. 겉흙이 마르면 충분히 관수", 특징: "꽃이 극락조를 닮아 붙여진 이름이다. \n\n공기정화 식물로 인테리어 식물로도 유명하다. \n\n많은 사람들이 극락조와 여인초를 동일한 것으로 알고 있는데 이는 잘못된 정보이다. 극락조는 길죽길죽하게 시원하게 뻗어있는 모양이고, 여인초와 달리 새 모양의 꽃을 피어낸다는 점에서 큰 차이가 있다.", 한줄설명: "  여인초랑 헷갈려")
  
]


var plantsAnimal: [Plant] = [
    Plant(이름: "율마", 원산지: "북부 아메리카",과명: "측백나무과",생육온도: "16-20도", 광요구도: "높은 광도(1,500~10,000 Lux) 요구되어 거실 창측이나 발코니에서 키우는 것이 좋음", 물주기: "봄, 여름, 가을에는 토양 표면이 말랐을때 충분히 관수하고 겨울에는 화분 흙이 대부분 말랐을때 충분히 관수함", 특징: "바람에 약하며 줄기 아랫부분의 잎이 떨어지면 황량한 느낌을 주지만 토피아리 형식으로 키울 수도 있다.\n\n크리스마스 트리로 실내에 장식하면 좋다.\n\n독성이 없는 식물로 반려동물과 함께 기르기에 적합하다.", 한줄설명: "  허브 향이 솔솔"),
    Plant(이름: "마오리소포라", 원산지: "뉴질랜드",과명: "아르고필룸과",생육온도: "10-25도", 광요구도: "반양지가 적당하여 직사광선은 피한다.", 물주기: "겉흙이 말랐을 때 주는데, 한번에 듬뿍 주는 것보다는 100-150ml정도의 소량을 주는 것이 좋다. 약간 건조하게 관리한다.", 특징: "국내에는 최근 보급된 만큼 높은 가격이 형성된다.\n\n키우는데 다소 난이도가 높기 때문에 처음 식물을 키우는 사람에게는 추천하지 않는다.\n\n황제의 꽃이라는 꽃말을 가진 노란색 별 모양의 꽃이 일년에 3-5번 핀다.\n\n독성이 없는 식물로 반려동물과 함께 키우기에 적합하다.", 한줄설명: "  감성 식물 끝판왕"),
    Plant(이름: "페페", 원산지: "인도, 브라질, 페루",과명: "후추과 ",생육온도: "21-25도", 광요구도: "반음지에서도 잘 자라지만 햇빛이 있는 곳에서 줄기와 잎에 힘이 생김", 물주기: "물은 좋아하는 편이 아니므로 봄여름가을에는 흙 표면이 마르면 물을 주고, 겨울에는 흙 대부분이 마르면 물을 준다.", 특징: "잎이나 줄기의 모양, 색에 따라 청페페, 홍페페, 황페페, 필리아, 아몬드, 줄리아 등으로 나뉜다.\n\n물을 많이 주면 잎에 물집이 생기거나 입이 퉁퉁 불어 노랗게 변한다. 이와 같은 증세를 보이면 상한 잎은 잘라내고 한동안 물주기를 멈춰야 한다.\n\n독성이 없는 식물로 반려동물과 함께 키우기에 적합하다", 한줄설명: "  취향별로 다양하게"),
    Plant(이름: "트리안",원산지: "뉴질랜드, 호주",과명: "마디풀과",생육온도: "5-20도", 광요구도: "통풍이 잘되고 밝은 장소", 물주기: "화분의 겉흙이 마르고 손가락으로 흙표면을 조금 헤쳐보아 속흙까지 말려들어가기 시작할 무렵준다. 일반적으로 2-3일에 한번씩 준다.", 특징: "열대성 상록 넝쿨 식물로 주로 실내 화단의 땅 위에 장식하는 지피용이나 공중걸이 인테리어 식물로 이용된다.\n\n실내의 건조함을 잡아 주기 때문에 가습기 효과를 얻을 수 있으며 일산화 탄소 제거 능력이 있어 주방 근처에 두어도 좋다.\n\n독성이 없는 식물로 반려동물과 함께 키우기에 적합하다.", 한줄설명: "  대표 행잉 플랜트"),
    Plant(이름: "틸란드시아", 원산지: "페루,에콰도르",과명: "파인애플과",생육온도: "21-25도", 광요구도: "중간 이상 높은 광도(800~10,000 Lux) 요구되어 거실 창측이나 발코니 내측에서 키우는 것이 좋음", 물주기: "자주 물을 분무하거나 주1회 저면 관수", 특징: "기존의 가드닝 방식과는 조금 다르게 키우는 에어플랜트로 땅에 뿌리를 내리지 않고 잎을 통해 영양분을 섭취하는 식물이다. \n\n뿌리는 나무나 돌에 달라붙어 착생하는 역할을 하며 실질적인 뿌리의 역할은 잎에 붙어있는 솜털, 트리콤이 한다.\n\n독성이 없는 식물로 반려동물과 함께 키우기에 적합하다.", 한줄설명: "  독특한 에어플랜트"),
    Plant(이름: "캣그라스",원산지: "아프리카, 유럽, 아시아",과명: "민트과",생육온도: "15-25도", 광요구도: "해가 잘 들고 통풍이 잘 되는 곳", 물주기: "흙이 마르지 않게 스프레이를 해준다.", 특징: "고양이가 좋아하는 풀로 실내에서 생활하는 고양이에게 스트레스를 해소해주는 효과가 있다. \n\n사료를 잘 먹지 않을 때 먹이에 조금씩 뿌려서 고양이에게 주어도 된다.\n\n잎과 줄기에는 네페탈락톤이라는 기름이 들어있어 페로몬이라는 화확물이 감지되어 고양이에게 행복감을 주는 일종의 화학반응이 일어나게 된다.\n\n독성이 없는 식물로 반려동물과 함께 키우기에 적합하다.", 한줄설명: "  고양이 세계의 마약")
  
]






struct PlantType {
    var type: [String]
    var plantAll: [[Plant]]
    
}



var plantType = PlantType(
    type : ["공기정화","그늘에서","다육식물","귀차니즘","인테리어","반려동물"],
    plantAll : [plantsClearAir,plantsShade,plantsDry,plantsLazy,plantsInterior,plantsAnimal]

)




