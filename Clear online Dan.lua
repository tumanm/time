-- Метаданные скрипта
script_name("Clear Online")
script_authors("Dan Aproxiado")
script_version_number("1.0")

-- Подключение библиотек
local sampev = require 'lib.samp.events'
require "lib.moonloader"

-- Функция: Обработка содержимого диалога
function processDialogContent(dialogId, style, title, button1, button2, text)
    print(string.format("ID диалога: %d\nЗаголовок: %s\nТекст: %s", dialogId, title, text))

    -- Пример: Обработка текста "Время в игре сегодня"
    if string.find(text, "Время в игре сегодня") then
        -- Время за сегодня
        local allhour, allmin = string.match(text, "Время в игре сегодня:		{ffcc00}(%d+) ч (%d+) мин")
        local afkhour, afkmin = string.match(text, "AFK за сегодня:		{FF7000}(%d+) ч (%d+) мин")
        
        -- Преобразование и расчет
        local facthour = tonumber(allhour) - tonumber(afkhour)
        local factmin = tonumber(allmin) - tonumber(afkmin)
        if factmin < 0 then
            factmin = factmin + 60
            facthour = facthour - 1
        end

        -- Время за вчера
        local yallhour, yallmin = string.match(text, "Время в игре вчера:		{ffcc00}(%d+) ч (%d+) мин")
        local yafkhour, yafkmin = string.match(text, "AFK за вчера:			{FF7000}(%d+) ч (%d+) мин")

        -- Преобразование и расчет
        local yfacthour = tonumber(yallhour) - tonumber(yafkhour)
        local yfactmin = tonumber(yallmin) - tonumber(yafkmin)
        if yfactmin < 0 then
            yfactmin = yfactmin + 60
            yfacthour = yfacthour - 1
        end

        -- Показ модифицированного диалога
        local updatedText = string.format(
            "%s\n\n{FFFFFF}Чистый онлайн сегодня: \t{9ACD32}%d ч %d мин\n{FFFFFF}Чистый онлайн вчера: \t\t{9ACD32}%d ч %d мин",
            text, facthour, factmin, yfacthour, yfactmin
        )
        sampShowDialog(dialogId, title, updatedText, button1, button2, style)
        return false -- Отключает стандартный диалог
    end

    -- Все остальные диалоги показываются без изменений
    return true
end

-- Хук события: При отображении диалога
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    -- Обработка диалога
    return processDialogContent(dialogId, style, title, button1, button2, text)
end

-- Утилита: Печать информации для отладки
function debugDialogInfo(dialogId, title, text)
    print("Отладочная информация:")
    print("ID диалога: " .. dialogId)
    print("Заголовок: " .. title)
    print("Текст: " .. text)
end
