*** Settings ***
Resource        base_keywords.robot
Suite Setup     Test Suite Setup
Suite Teardown  Test Suite Teardown


*** Variables ***

${MODE}              lots
${RESOURCE}          lots
@{USED_ROLES}        tender_owner  viewer
${NUMBER_OF_ITEMS}   ${3}


*** Test Cases ***
Можливість створити лот
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Реєстрація лоту
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      create_lot
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Завантажити дані про тендер
  Можливість зареєструвати актив
  Можливість змінити статус активу на pending


Можливість знайти лот по ідентифікатору
  [Tags]   ${USERS.users['${viewer}'].broker}: Пошук лоту
  ...      viewer  tender_owner
  ...      ${USERS.users['${viewer}'].broker}  ${USERS.users['${tender_owner}'].broker}
  ...      find_lot
  Можливість знайти актив по ідентифікатору для усіх користувачів


##############################################################################################
#             Відображення основних даних актива
##############################################################################################

Відображення статусу 'pending'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити відображення поля status тендера із pending для користувача ${viewer}


Відображення статусу 'pending' активів лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус активів  ${viewer}  pending


Можливість додати документацію до лоту
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Додання документації
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      add_doc
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість додати документацію до тендера


Відображення вмісту документації до лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення документації
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      add_doc_content
  Звірити відображення вмісту документа ${USERS.users['${tender_owner}'].tender_document.doc_id} із ${USERS.users['${tender_owner}'].tender_document.doc_content} для користувача ${viewer}


Можливість змінити поле relatedLot актива
  [Tags]   ${USERS.users['${viewer}'].broker}: Пошук активу
  ...      viewer  tender_owner
  ...      ${USERS.users['${viewer}'].broker}  ${USERS.users['${tender_owner}'].broker}
  ...      modify_relatedLot
  ${asset}=  Run As  ${tender_owner}  Змінити поле relatedLot актива  ${USERS.users['${tender_owner}'].assets_id[0]}  ${USERS.users['${tender_owner}'].tender_data.data.id}


Відображення заголовку лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити відображення поля title тендера для користувача ${viewer}


Відображення опису лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля description тендера для користувача ${viewer}


Відображення ідентифікатора лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotID тендера із ${TENDER['TENDER_UAID']} для користувача ${viewer}


Відображення номера лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotIdentifier тендера для користувача ${viewer}


Відображення назви організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.name тендера для користувача ${viewer}


Відображення схеми ідентифікатора організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.identifier.scheme тендера для користувача ${viewer}


Відображення ідентифікатора організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.identifier.id тендера для користувача ${viewer}


Відображення легально зареєстрованої назви організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.identifier.legalName тендера для користувача ${viewer}


Відображення імені контактної особи організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.contactPoint.name тендера для користувача ${viewer}


Відображення контактного номера організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.contactPoint.telephone тендера для користувача ${viewer}


Відображення поштового індексу в адресі організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.address.postalCode тендера для користувача ${viewer}


Відображення країни в адресі організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.address.countryName тендера для користувача ${viewer}


Відображення області в адресі організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.address.region тендера для користувача ${viewer}


Відображення населеного пункту в адресі організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.address.locality тендера для користувача ${viewer}


Відображення вулиці в адресі організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      lot_view
  Звірити відображення поля lotCustodian.address.streetAddress тендера для користувача ${viewer}

##############################################################################################
#             Редагування лоту
##############################################################################################

Можливість змінити назву лоту
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  ${new_title}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_title=${new_title}
  Можливість змінити поле title тендера на ${new_title}


Відображення зміненої назви лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  title
  Звірити відображення поля title тендера із ${USERS.users['${tender_owner}'].new_title} для користувача ${viewer}


Можливість змінити опис лоту
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  ${new_description}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_description=${new_description}
  Можливість змінити поле description тендера на ${new_description}


Відображення зміненого опису лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  description
  Звірити відображення поля description тендера із ${USERS.users['${tender_owner}'].new_description} для користувача ${viewer}


Можливість змінити ім'я контактної особи організації розпорядника лоту
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  ${new_name}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_name=${new_name}
  Можливість змінити поле lotCustodian.contactPoint.name тендера на ${new_name}


Відображення зміненого імені контактної особи організації розпорядника лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.assetCustodian.contactPoint}  name
  Звірити відображення поля lotCustodian.contactPoint.name тендера із ${USERS.users['${tender_owner}'].new_name} для користувача ${viewer}


Можливість видалити лот
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість видалити лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      delete_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість видалити актив


Відображення статусу 'deleted'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      delete_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити відображення поля status тендера із deleted для користувача ${viewer}


Відображення статусу 'pending' активів лоту після видалення лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      delete_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус активів  ${viewer}  pending


Можливість змінити статус лоту на 'verification'
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      verification_lot
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість змінити статус активу на verification


# Відображення статусу 'verification'
#   [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
#   ...      viewer
#   ...      ${USERS.users['${viewer}'].broker}
#   ...      verification_lot
#   [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
#   Звірити статус  verification  ${viewer}  ${TENDER['TENDER_UAID']}


# Відображення статусу 'verification' активів лоту 
#   [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
#   ...      viewer
#   ...      ${USERS.users['${viewer}'].broker}
#   ...      verification_lot
#   [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
#   Звірити статус активів  ${viewer}  verification


Відображення статусу 'active.salable'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      salable_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус  active.salable  ${viewer}  ${TENDER['TENDER_UAID']}


Відображення статусу 'active' активів лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      salable_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус активів  ${viewer}  active


Можливість розформувати лот
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      dissolved_lot
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість розформувати лот


Відображення статусу 'pending.dissolution'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      dissolved_lot_pending_dissolution
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус  pending.dissolution  ${viewer}  ${TENDER['TENDER_UAID']}


Відображення статусу 'dissolved'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      dissolved_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус  dissolved  ${viewer}  ${TENDER['TENDER_UAID']}


Відображення статусу 'pending' активів лоту після розформування лоту
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      dissolved_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус активів  ${viewer}  pending


Можливість змінити статус лоту на 'recomposed'
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      recomposed_lot
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість змінити статус активу на recomposed


Відображення статусу 'pending' після 'recomposed'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус  pending  ${viewer}  ${TENDER['TENDER_UAID']}


Відображення статусу 'pending' активів лоту після 'recomposed'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус активів  ${viewer}  pending


Можливість змінити назву лоту після 'recomposed'
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  ${new_title}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_title=${new_title}
  Можливість змінити поле title тендера на ${new_title}


Відображення зміненої назви лоту після 'recomposed'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  title
  Звірити відображення поля title тендера із ${USERS.users['${tender_owner}'].new_title} для користувача ${viewer}


Можливість змінити опис лоту після 'recomposed'
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  ${new_description}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_description=${new_description}
  Можливість змінити поле description тендера на ${new_description}


Відображення зміненого опису лоту після 'recomposed'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  description
  Звірити відображення поля description тендера із ${USERS.users['${tender_owner}'].new_description} для користувача ${viewer}


Можливість змінити статус лоту на 'verification' після 'recomposed'
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати лот
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      recomposed_lot
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість змінити статус активу на verification


Відображення статусу 'active.salable' після 'recomposed'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус  active.salable  ${viewer}  ${TENDER['TENDER_UAID']}


Відображення статусу 'active' активів лоту після 'recomposed'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення статусів активів
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      recomposed_lot
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити статус активів  ${viewer}  active