-- ���������� �������
script_name("Clear Online")
script_authors("Dan Aproxiado")
script_version_number("1.0")

-- ����������� ���������
local sampev = require 'lib.samp.events'
require "lib.moonloader"

-- �������: ��������� ����������� �������
function processDialogContent(dialogId, style, title, button1, button2, text)
    print(string.format("ID �������: %d\n���������: %s\n�����: %s", dialogId, title, text))

    -- ������: ��������� ������ "����� � ���� �������"
    if string.find(text, "����� � ���� �������") then
        -- ����� �� �������
        local allhour, allmin = string.match(text, "����� � ���� �������:		{ffcc00}(%d+) � (%d+) ���")
        local afkhour, afkmin = string.match(text, "AFK �� �������:		{FF7000}(%d+) � (%d+) ���")
        
        -- �������������� � ������
        local facthour = tonumber(allhour) - tonumber(afkhour)
        local factmin = tonumber(allmin) - tonumber(afkmin)
        if factmin < 0 then
            factmin = factmin + 60
            facthour = facthour - 1
        end

        -- ����� �� �����
        local yallhour, yallmin = string.match(text, "����� � ���� �����:		{ffcc00}(%d+) � (%d+) ���")
        local yafkhour, yafkmin = string.match(text, "AFK �� �����:			{FF7000}(%d+) � (%d+) ���")

        -- �������������� � ������
        local yfacthour = tonumber(yallhour) - tonumber(yafkhour)
        local yfactmin = tonumber(yallmin) - tonumber(yafkmin)
        if yfactmin < 0 then
            yfactmin = yfactmin + 60
            yfacthour = yfacthour - 1
        end

        -- ����� ����������������� �������
        local updatedText = string.format(
            "%s\n\n{FFFFFF}������ ������ �������: \t{9ACD32}%d � %d ���\n{FFFFFF}������ ������ �����: \t\t{9ACD32}%d � %d ���",
            text, facthour, factmin, yfacthour, yfactmin
        )
        sampShowDialog(dialogId, title, updatedText, button1, button2, style)
        return false -- ��������� ����������� ������
    end

    -- ��� ��������� ������� ������������ ��� ���������
    return true
end

-- ��� �������: ��� ����������� �������
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    -- ��������� �������
    return processDialogContent(dialogId, style, title, button1, button2, text)
end

-- �������: ������ ���������� ��� �������
function debugDialogInfo(dialogId, title, text)
    print("���������� ����������:")
    print("ID �������: " .. dialogId)
    print("���������: " .. title)
    print("�����: " .. text)
end
