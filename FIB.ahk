#Requires AutoHotkey v2.0
StateUI:=True
ExtraUI:=False
MarkUI := False
SleepTime:=300

MyGui1 := Gui()
MyGui2 := Gui()
MyGui3 := Gui()

WS_EX_TRANSPARENT := 0x20
WS_EX_LAYERED := 0x80000

MyGui1.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow +Disabled")
MyGui1.BackColor := "000000"
MyGui1.SetFont("w600 s10 c19FF00")
MyGui1.Add("Text",, "Ctrl + Num 1   |   Жетон")
MyGui1.Add("Text",, "Ctrl + Num 4   |   вызов адвоката")
MyGui1.Add("Text",, "Ctrl + Num 6   |   Mark Code")
MyGui1.Add("Text",, "Ctrl + Num 7   |   Вытащить")
MyGui1.Add("Text",, "Ctrl + Num 9   |   Запихнуть")
MyGui1.Add("Text",, "Num -             |   узнать ОПЗ")
MyGui1.Add("Text",, "Ctrl + Num 5   |   Extra Tab")
MyGui1.Show()
WinSetTransColor "222222 70"
WinSetExStyle + WS_EX_LAYERED|WS_EX_TRANSPARENT
MyGui1.GetPos(, , &Width,)
MyGui1.Move(2560-Width,,)

F12:: 
{
    global StateUI
    global MyGui1
    if (StateUI)
        {
            MyGui1.Hide()
            StateUI:=False
        }
    Else
        {        
            MyGui1.Show()
            StateUI:=True
        }
}

F9:: 
{
MyGui := Gui()
MyGui.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow")
WinSetTransColor "EEAA99 150"
MyGui.SetFont("w500 s20 cBlack")
MyGui.Add("Text",, "Перезапуск AHK")
MyGui.Show
sleep SleepTime
MyGui.Destroy()
Reload
}

getInput(title, hint)
{
    return InputBox(title, hint, "w250 h100", )    
}

NumpadSub::
{
InputBoxObj := getInput("Введите динамик ID", "опз")
SendInChat("/do Какие идентификационные знаки есть у гражданина @" InputBoxObj.Value " и что на них написано?")
}
 

Ctrl & Numpad1::
{
    SendInChat("/do На поясе висит жетон [FIB | CID | 71838].{enter}")
}

Ctrl & Numpad7::
{
    InputBoxObj := getInput("Введите динамик ID", "вытащить")
    SendInChat("/pull " InputBoxObj.Value)
}

Ctrl & Numpad9::
{
    InputBoxObj := getInput("Введите динамик ID", "посадить")
    SendInChat("/put " InputBoxObj.Value)
}

Ctrl & Numpad4::
{
    SendInChat("/dep to GOV: Адвоката в КПЗ ЛСПД",,False)
}

Ctrl & Numpad5::
{
    ExtraGUI()
}

SendInChat(text, sleep_timer := SleepTime, enter := True)
{
    sleep sleep_timer
    Sendinput "{t}"
    sleep sleep_timer
    if (enter)
        {
            SendInput text
            if (StrLen(text)>50)
                sleep sleep_timer 
            Sendinput " {Enter}"
            return
        } 
    Sendinput text
    return         
}

SendInChatMany(arr, sleep_timer := SleepTime, enter := True)
{
    for line in arr
        SendInChat(line, sleep_timer, enter)
}

;Esc::
;{
;    global ExtraUI 
;    if (ExtraUI)
;        {
;            ExtraGUI()
;        }
;}
MarkGUI(*)
{
    global MyGui3
    global MarkUI
    if (MarkUI)
        {
            MyGui3.Destroy()
            MarkUI := False
        }
        Else
            {
                MyGui3 := Gui()
                MyGui3.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow")                
                MyGui3.BackColor := "000000"
                MyGui3.SetFont("w600 s10 c19FF00")
                MyGui3.Add("Text",, "Группа вооружённых")
                MyGui3.Add("Button", "Default", "/mark CODE 7").OnEvent("Click", Button_click_parser)
                MyGui3.Add("Text",, "Сотрудник ранен/убит")
                MyGui3.Add("Button", "Default", "/mark CODE 0").OnEvent("Click", Button_click_parser)
                MyGui3.Add("Text",, "Вызов машины")
                MyGui3.Add("Button", "Default", "/mark CODE 10-20").OnEvent("Click", Button_click_parser)
                MyGui3.Show()
                WinSetTransColor "222222 200"
                MarkUI := True
            }
}
;MarkGUI()

Button_click_parser(ctrlHwnd:=0, guiEvent:="", eventInfo:="", errLvl:="")
{
name:=ctrlHwnd.Text
MarkGUIHide()
ExtraGUIHide()
if (name ="Стирание следов силового допроса")
    {
        text := 
        [
            "/me достал флеш-карту с боди камеры",
            "/me вставил флеш-карту в корпус компьютера",
            "/me нажал на кнопку включения компьютера",
            "/do Компьютер включен.",
            "/me открыл программу для монтажа видео на компьютере",
            "/do Программа запущена.",
            "/me перетащил видео с боди камеры на линию редактирования",
            "/me начал редактировать видео",
            "/do С видео вырезаны все следы насилия и незаконные действия сотрудников FIB.",
            "/me закрыл программу",
            "/me вытащил флеш-карту и положил в правый карман",
            "/do Флеш-карта в кармане.",
            "/me нажал на кнопку выключения компьютера",
            "/do Компьютер выключен."
        ]
        SendInChatMany(text)
        return
    }
if (name ="Скинуть документы в бардачок")
    {
        text := 
        [
            "/me достал документы из правого кармана",
            "/do Документы в руке.",
            "/me открыл бардачок автомобиля и положил в него все документы",
            "/do Документы в бардачке.",
            "/me закрыл бардачок автомобиля",
            "/do Бардачок автомобиля закрыт."
        ]
        SendInChatMany(text)
        return
    }
if (name ="Отпечатки пальцев")
    {
        text := 
        [
            "/do На столе лежит набор стекол для снятия отпечатков, дактилоскопический порошок и скотч.",
            "/me взял набор со стола, приставил каждый палец задержанного к отдельным стеклам",
            "/me взял дактилоскопический порошок и присыпал им стекла, сдул излишки",
            "/do Отпечатки появились на стеклах.",
            "/me взял скотч, снял им отпечатки со стекла и наклеил на специальных бланк",
            "/do На столе стоит компьютер.",
            "/do Компьютер выключен.",
            "/me включил компьютер",
            "/do Компьютер включен.",
            "/me занес бланк с отпечатками в программу на компьютере",
            "/me запустил программу по поиску отпечатков",
            "/do Совпадения найдены, личность установлена."
        ]
        SendInChatMany(text)
        return
    }
if (name ="Полиграф включить")
{
    text := 
    [
        "/do На полке склада стоит ноутбук, измерительные устройства и полиграф для проведения допроса.",
        "/me взял ноутбук, измерительные устройства и полиграф в руки и понес с собой",
        "/do В руках агента ноутбук, полиграф и измерительные устройства для проведения допроса.",
        "/me поставил на стол ноутбук и подключил к нему с помощью проводов полиграф",
        "/me открыл экран ноутбука, нажал кнопку включения и ввел пароль",
        "/do Вход успешен.",
        "/me включил специальную программу для работы с полиграфом",
        "/me нажал на небольшую красную кнопочку на полиграфе",
        "/do Полиграф включен.",
        "/me надел на правую руку гражданина датчик артериального давления и частоты пульса",
        "/me надел на 2 пальца левой руки 2 датчика потоотделения",
        "/me надел на человека опоясывающий грудь датчик глубины дыхания",
        "/me подключил измерительные устройства к полиграфу при помощи проводов",
        "/do Полиграф готов к проведению измерений."
    ]
    SendInChatMany(text)
    return
}
if (name ="Полиграф рисует графики")
{
    text := 
    [
        "/do На экране ноутбука начали рисоваться графики согласно полученным данным."
    ]
    SendInChatMany(text)
    return
}
if (name ="Полиграф выключить")
{
    text := 
    [
        "/me снял с правой руки человека датчик давления и частоты пульса после чего положил его на стол",
        "/me снял с пальцев правой руки человека датчики потооделения и положил их на стол",
        "/me снял с груди чело-века датчик глубины дыхания и положил его на стол",
        "/do На столе лежат несколько датчиков, стоит включенный ноутбук, а также полиграф.",
        "/me нажал на кнопку выключения полиграфа и ноутбука"
    ]
    SendInChatMany(text)
    return
} 
if (name ="Диктофон включение")
    {
        text := 
        [
            "/do Диктофон в правом кармане.",
            "/me достал диктофон",
            "/do Диктофон в руке.",
            "/me положил диктофон на стол",
            "/do Диктофон на столе.",
            "/me включил диктофон",
            "/do Диктофон работает и ведет запись на microSD FlashCard"
        ]
        SendInChatMany(text)
        return
    }   
if (name ="Диктофон выключение")
    {
        text := 
        [
            "/me выключил диктофон",
            "/do Диктофон выключен.",
            "/me положил диктофон в правый карман штанов",
            "/do Диктофон в правом кармане штанов."
        ]
        SendInChatMany(text)
        return
    } 
SendInChat(name)
}

MarkGUIHide(*)
{
    global MyGui3
    global MarkUI
    if (MarkUI)
        {
            MyGui3.Destroy()
            MarkUI := False
        }
}
ExtraGUIHide(*)
{
    global MyGui2
    global ExtraUI
    if (ExtraUI)
        {
            MyGui2.Destroy()
            ExtraUI := False
        }
}


ExtraGUI(*)
{
    global MyGui2
    global ExtraUI
    if (ExtraUI)
        {
            MyGui2.Destroy()
            ExtraUI := False
        }
        Else
            {
                MyGui2 := Gui()
                MyGui2.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow")
                WinSetTransColor "222222 200"
                MyGui2.BackColor := "000000"
                MyGui2.SetFont("w600 s10 c19FF00")

                MyGui2.Add("Text",, "CID")
                MyGui2.Add("Button", "Default", "Стирание следов силового допроса").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Button", "Default", "Скинуть документы в бардачок").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Button", "Default", "Отпечатки пальцев").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Text",, "Полиграф")           
                MyGui2.Add("Button", "Default", "Полиграф включить").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Button", "Default", "Полиграф рисует графики").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Button", "Default", "Полиграф выключить").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Text",, "Диктофон")
                MyGui2.Add("Button", "Default", "Диктофон включение").OnEvent("Click", Button_click_parser)
                MyGui2.Add("Button", "Default", "Диктофон выключение").OnEvent("Click", Button_click_parser)
                MyGui2.Show()
                ExtraUI := True
            }
}


Ctrl & Numpad6::
{
    MarkGUI()
}
