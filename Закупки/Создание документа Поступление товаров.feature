﻿#language: ru

@tree

Функционал: создание документа Поступление товаров

Как менеджер по закупкам я хочу
создание документа поступление товаров 
чтобы поставить товар на учет

Контекст:
Дано Я открыл новый сеанс TestClient или подключил уже существующий

Сценарий: создание документа поступление товаров
// Создание
* Открытие формы создания документа
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю 'Закупки' 'Приходные накладные'
	Тогда открылось окно 'Приходные накладные'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Приходная накладная (создание)'
* Заполнение шапки документа
	И в табличном документе 'ТаблицаДляПросмотра' я перехожу к ячейке "R1C1"
	И из выпадающего списка с именем "Контрагент" я выбираю точное значение 'ПИРО - РОСС'
	И я нажимаю кнопку выбора у поля с именем "Контрагент"
	Тогда открылось окно 'Контрагенты: Поставщики'
	И в таблице "Список" я перехожу к строке:
		| 'Представление' |
		| 'НовочЛит'      |
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Приходная накладная (создание) *'
	Тогда элемент формы с именем "Контрагент" стал равен 'НовочЛит'	
	И в поле с именем 'НомерВходящегоДокумента' я ввожу текст '123'
	И я нажимаю кнопку выбора у поля с именем "ДатаВходящегоДокумента"
	И в поле с именем 'ДатаВходящегоДокумента' я ввожу текст '16.03.2023'
* Заполнение товарной части
	И я нажимаю на кнопку с именем 'Добавить'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке 'авокадо'
	И в таблице "Запасы" я активизирую поле с именем "ЗапасыКоличество"
	И в таблице "Запасы" в поле с именем 'ЗапасыКоличество' я ввожу текст '12,000'
	И я перехожу к следующему реквизиту
	И в таблице "Запасы" я нажимаю кнопку выбора у реквизита с именем "ЗапасыЕдиницаИзмерения"
	И в таблице "Запасы" я активизирую поле с именем "ЗапасыЦена"
	И в таблице "Запасы" в поле с именем 'ЗапасыЦена' я ввожу текст '1 244,00'
	И я перехожу к следующему реквизиту
	И в таблице "Запасы" я завершаю редактирование строки
	И я нажимаю на кнопку "Записать"
* Проверка заполнения табличной части
	Тогда таблица "Запасы" содержит строки:
		| '% НДС' | 'Номенклатура' | 'Характеристика'    | 'Содержание' | 'Сумма НДС' | 'Страна происхождения' | 'Партия'            | 'Серии номенклатуры' | 'Количество' | 'Всего'     | 'Ед.' | 'Цена'     | 'Комментарий' | 'Сумма'     |
		| '20%'   | 'Авокадо'      | '<Не используется>' | '*'          | '2 488,00'  | ''                     | '<Не используется>' | ''                   | '12,000'     | '14 928,00' | 'кг'  | '1 244,00' | ''            | '14 928,00' |
* Установка номера
	И Я запоминаю значение поля "Номер" как "$Номер$"		
* Проведение документа
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна 'Приходная накладная (создание) *' в течение 20 секунд
	Тогда открылось окно 'Приходные накладные'	
* Проверка создания документа
	И таблица "Список" содержит строки :
		| 'Номер'   |
		| '$Номер$' |

Сценарий: проверка наличия в справочнике номенклатуры 
	И В командном интерфейсе я выбираю 'Главное' 'Номенклатура'
	Тогда открылось окно 'Номенклатура'
	И таблица "СписокЗапасы" содержит строки :
		| 'Наименование'    |
		| 'Виноград желтый' |