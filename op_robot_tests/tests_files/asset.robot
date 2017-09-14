*** Settings ***
Resource        base_keywords.robot
Suite Setup     Test Suite Setup
Suite Teardown  Test Suite Teardown


*** Variables ***

${MODE}              assets
@{USED_ROLES}        tender_owner  viewer
${API_KEY}           b31ef66eabcc44e3b5a5347b57539f49


*** Test Cases ***
Можливість зареєструвати актив
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Реєстрація активу
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      create_asset
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість зареєструвати актив
  Можливість змінити статус активу на pending


Можливість знайти актив по ідентифікатору
  [Tags]   ${USERS.users['${viewer}'].broker}: Пошук активу
  ...      viewer  tender_owner
  ...      ${USERS.users['${viewer}'].broker}  ${USERS.users['${tender_owner}'].broker}
  ...      find_asset
  Можливість знайти актив по ідентифікатору для усіх користувачів


##############################################################################################
#             Відображення основних даних актива
##############################################################################################

Відображення статусу 'pending'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити відображення поля status тендера із pending для користувача ${viewer}


Відображення заголовку активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Звірити відображення поля title тендера для користувача ${viewer}


Відображення опису активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля description тендера для користувача ${viewer}


Відображення початкової вартості активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля value.amount тендера для користувача ${viewer}


Відображення валюти активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля value.currency тендера для користувача ${viewer}


Відображення ПДВ в бюджеті активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля value.valueAddedTaxIncluded тендера для користувача ${viewer}


Відображення ідентифікатора активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetID тендера із ${TENDER['TENDER_UAID']} для користувача ${viewer}


Відображення схеми класифікації активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля classification.scheme тендера для користувача ${viewer}


Відображення ідентифікатора класифікації активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля classification.id тендера для користувача ${viewer}


Відображення опису класифікації активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля classification.description тендера для користувача ${viewer}


Відображення масиву додаткових класифікацій активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля additionalClassifications тендера для користувача ${viewer}


Відображення назви одиниці активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля unit.name тендера для користувача ${viewer}


Відображення коду одиниці активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля unit.code тендера для користувача ${viewer}


Відображення кількості одиниць активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля quantity тендера для користувача ${viewer}


Відображення назви організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.name тендера для користувача ${viewer}


Відображення схеми ідентифікатора організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.identifier.scheme тендера для користувача ${viewer}


Відображення ідентифікатора організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.identifier.id тендера для користувача ${viewer}


Відображення легально зареєстрованої назви організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.identifier.legalName тендера для користувача ${viewer}


Відображення імені контактної особи організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.contactPoint.name тендера для користувача ${viewer}


Відображення контактного номера організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.contactPoint.telephone тендера для користувача ${viewer}


Відображення поштового індексу в адресі організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.address.postalCode тендера для користувача ${viewer}


Відображення країни в адресі організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.address.countryName тендера для користувача ${viewer}


Відображення області в адресі організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.address.region тендера для користувача ${viewer}


Відображення населеного пункту в адресі організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.address.locality тендера для користувача ${viewer}


Відображення вулиці в адресі організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      asset_view
  Звірити відображення поля assetCustodian.address.streetAddress тендера для користувача ${viewer}

##############################################################################################
#             Редагування актива
##############################################################################################

Можливість змінити назву активу
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати актив
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  ${new_title}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_title=${new_title}
  Можливість змінити поле title тендера на ${new_title}


Відображення зміненої назви активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  title
  Звірити відображення поля title тендера із ${USERS.users['${tender_owner}'].new_title} для користувача ${viewer}


Можливість змінити опис активу
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати актив
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  ${new_description}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_description=${new_description}
  Можливість змінити поле description тендера на ${new_description}


Відображення зміненого опису активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  description
  Звірити відображення поля description тендера із ${USERS.users['${tender_owner}'].new_description} для користувача ${viewer}


Можливість змінити початкову вартість активу
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати актив
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  ${new_amount}=  create_fake_amount
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_amount=${new_amount}
  Можливість змінити поле value.amount тендера на ${new_amount}


Відображення зміненої початкової вартості активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data.value}  amount
  Звірити відображення поля value.amount тендера із ${USERS.users['${tender_owner}'].new_amount} для користувача ${viewer}


Можливість змінити кількість одиниць активу
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати актив
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  ${new_quantity}=  create_fake_amount
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_quantity=${new_quantity}
  Можливість змінити поле quantity тендера на ${new_quantity}


Відображення зміненої кількості одиниць активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.data}  quantity
  Звірити відображення поля quantity тендера із ${USERS.users['${tender_owner}'].new_quantity} для користувача ${viewer}


Можливість змінити ім'я контактної особи організації розпорядника активу
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість редагувати актив
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  ${new_name}=  create_fake_sentence
  Set To Dictionary  ${USERS.users['${tender_owner}']}  new_name=${new_name}
  Можливість змінити поле assetCustodian.contactPoint.name тендера на ${new_name}


Відображення зміненого імені контактної особи організації розпорядника активу
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      modify_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Run Keyword And Ignore Error  Remove From Dictionary  ${USERS.users['${viewer}'].tender_data.assetCustodian.contactPoint}  name
  Звірити відображення поля assetCustodian.contactPoint.name тендера із ${USERS.users['${tender_owner}'].new_name} для користувача ${viewer}


Можливість видалити актив
  [Tags]   ${USERS.users['${tender_owner}'].broker}: Можливість видалити актив
  ...      tender_owner
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      delete_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${tender_owner}
  [Teardown]  Оновити LAST_MODIFICATION_DATE
  Можливість видалити актив


Відображення статусу 'deleted'
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних активу
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      delete_asset
  [Setup]  Дочекатись синхронізації з майданчиком  ${viewer}
  Оновити LAST_MODIFICATION_DATE
  Звірити відображення поля status тендера із deleted для користувача ${viewer}