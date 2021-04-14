$PBExportHeader$w_con_balance.srw
forward
global type w_con_balance from w_int_con_empresa
end type
type gb_2 from groupbox within w_con_balance
end type
type gb_cuenta from groupbox within w_con_balance
end type
type em_fechadesde from u_em_campo within w_con_balance
end type
type gb_1 from groupbox within w_con_balance
end type
type cb_consulta from u_boton within w_con_balance
end type
type em_fechahasta from u_em_campo within w_con_balance
end type
type st_1 from statictext within w_con_balance
end type
type pb_imprimir_preli from picturebutton within w_con_balance
end type
type em_cuentadesde from u_em_campo within w_con_balance
end type
type st_2 from statictext within w_con_balance
end type
type em_cuentahasta from u_em_campo within w_con_balance
end type
type dw_1 from datawindow within w_con_balance
end type
type cb_todos from commandbutton within w_con_balance
end type
type dw_niveles from datawindow within w_con_balance
end type
type ddlb_origen from dropdownlistbox within w_con_balance
end type
type pb_2 from upb_salir within w_con_balance
end type
type dw_listado from datawindow within w_con_balance
end type
type em_pagina from u_em_campo within w_con_balance
end type
type st_4 from statictext within w_con_balance
end type
type pb_fichero from picturebutton within w_con_balance
end type
type dw_2 from datawindow within w_con_balance
end type
end forward

global type w_con_balance from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2949
integer height = 2156
string title = "Consulta de Movimientos"
gb_2 gb_2
gb_cuenta gb_cuenta
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
pb_imprimir_preli pb_imprimir_preli
em_cuentadesde em_cuentadesde
st_2 st_2
em_cuentahasta em_cuentahasta
dw_1 dw_1
cb_todos cb_todos
dw_niveles dw_niveles
ddlb_origen ddlb_origen
pb_2 pb_2
dw_listado dw_listado
em_pagina em_pagina
st_4 st_4
pb_fichero pb_fichero
dw_2 dw_2
end type
global w_con_balance w_con_balance

type variables
Integer mes,anyo
String moneda_emp
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_ayuda_nivel ()
public function datetime dias_mes (integer el_mes, integer el_anyo)
public subroutine f_cargar2 (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);DataStore data
String  	sel,cuenta,origend,origenh,fechin
String  	c[],antec[],n[]
Dec 		j,r,xdebe,xhaber,niveles,g
Dec		debe[],haber[],debeper[],haberper[],dig[]
Dec 		h = 0
Integer	mes_apunte,mesi,anyi,digi
DateTime	fecapu,fperdesde,fperhasta,fejedesde,fejehasta
string origen_malo


fejedesde = DateTime(Date(em_fechadesde.text))
fejehasta = DateTime(Date(em_fechahasta.text))
mesi	= Month(Date(em_fechahasta.text))
anyi	= Year(Date(em_fechahasta.text))
fechin = '01/'+String(mesi)+'/'+String(anyi)
fperdesde = DateTime(Date(fechin))
fperhasta = dias_mes(Month(Date(em_fechahasta.text)),Year(Date(em_fechahasta.text)))

// Controlamos los origenes contables
CHOOSE CASE ddlb_origen.text	
	CASE "Antes Explotación"
		origend = '0'
		origenh = '96'
		origen_malo = "'" + "102" + "','" + "100" + "'"
	CASE "Antes Cierre"
		origend = '0'
		origenh = '97'
		origen_malo = "'" + "100" + "'"
	CASE "Todos"
		origend = '0'
		origenh = '99999'
		origen_malo = "''"
END CHOOSE

// Buscamos el nivel mas bajo para hacer los totales en datawindow
j = dw_niveles.RowCount()

FOR r = 1 TO j
	IF dw_niveles.GetItemString(r,"marca") = "S" THEN
		digi = dw_niveles.GetItemNumber(r,"digitos")
		EXIT
	END IF
NEXT

IF digi = 0 THEN
	f_mensaje("ERROR","Debe marcar algún nivel contable")
	RETURN
END IF
dw_data.SetTransObject(SQLCA)
dw_data.Reset()
dw_data.Retrieve(codigo_empresa,fperdesde,fperhasta,fejedesde,fejehasta,moneda_emp,Dec(em_pagina.text),digi)
dw_data.SetRedraw(FALSE)

j = dw_niveles.RowCount()

FOR r = 1 TO j
	n[r] = dw_niveles.GetItemString(r,"marca")
NEXT

f_mensaje_proceso("Procesando",1,100)

sel = "Select cuenta,contaapun.fapunte, sum(contaapun.debe) debe,sum(contaapun.haber) haber " +&
 " FROM contaapun  " +&
 " WHERE ( contaapun.ejercicio = " + String(anyo) +") "+&
 "	AND   ( contaapun.empresa = '"+ codigo_empresa + "' ) "+&
 "	AND   ( contaapun.origen not in ("+ origen_malo + ")) "+&           
 "	AND   ( contaapun.fapunte BETWEEN '"+ String(Datetime(Date(em_fechadesde.text)),"dd/mm/yy") + "' AND '" + String(Datetime(Date(em_fechahasta.text)),"dd/mm/yy") +"') "+&
 "	AND   ( contaapun.cuenta BETWEEN '"+ Trim(em_cuentadesde.text) + "' AND '" + Trim(em_cuentahasta.text) +"') "+&
 " GROUP BY cuenta,fapunte"+&
 " ORDER BY cuenta "

//data = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, data)

SELECT contaparam.niveles,contaparam.digitos1,contaparam.digitos2,   
       contaparam.digitos3,contaparam.digitos4,contaparam.digitos5,   
       contaparam.digitos6,contaparam.digitos7,contaparam.digitos8,   
       contaparam.digitos9  
    INTO :niveles,:dig[1],:dig[2],:dig[3],:dig[4],:dig[5],   
         :dig[6],:dig[7],:dig[8],:dig[9]      FROM contaparam  
WHERE contaparam.ejercicio = :anyo
AND   contaparam.empresa   = :codigo_empresa;

FOR g = 1 To niveles
	SetNUll(antec[g])
	debe[g]  = 0
	haber[g] = 0
	debeper[g]  = 0
	haberper[g] = 0
Next

r = data.RowCount()

For j = 1 To r + 1
	
	IF j < r + 1 THEN
		cuenta 	= data.GetItemSTring(j,"cuenta")
		xdebe 	= data.GetItemNumber(j,"debe")
		xhaber  	= data.GetItemNUmber(j,"haber")
		fecapu  	= data.GetItemDateTime(j,"fapunte")
	END IF
	For g = 1 To niveles
		IF n[g] ="N" THEN continue
		c[g]     = Mid(cuenta,1,dig[g])
		IF (Not IsNull(antec[g]) and antec[g] <> c[g]) or j = r + 1 Then
			h = h +1
			dw_data.InsertRow(h)	
			dw_data.SetItem(h,"cuenta",antec[g])
			dw_data.SetItem(h,"debe",debe[g])
			dw_data.SetItem(h,"haber",haber[g])
			dw_data.SetItem(h,"debeper",debeper[g])
			dw_data.SetItem(h,"haberper",haberper[g])
			dw_data.SetItem(h,"nombre_cuenta",f_nombre_contaplan(anyo,codigo_empresa,antec[g]))
			debe[g] 		= 0
			haber[g] 	= 0
			debeper[g] 	= 0
			haberper[g] = 0
		END IF
		debe[g]  = debe[g]  + xdebe
		haber[g] = haber[g] + xhaber
		// Acumulamos en periodo si corresponde
		IF Month(Date(fecapu)) = mes THEN
			debeper[g]  = debeper[g]  + xdebe
			haberper[g] = haberper[g] + xhaber
		END IF
	NEXT

	For g =1 To niveles
		IF n[g] ="N" Then continue
		antec[g] = c[g]
	Next
Next

f_mensaje_proceso("Procesando",100,100)
dw_data.SetSort("cuenta")
dw_data.Sort()
dw_data.SetRedraw(TRUE)
Destroy(data)

end subroutine

public subroutine f_ayuda_nivel ();integer i,niveles,dig[]

SELECT contaparam.niveles,contaparam.digitos1,contaparam.digitos2,
		 contaparam.digitos3,contaparam.digitos4,contaparam.digitos5,   
		 contaparam.digitos6,contaparam.digitos7,contaparam.digitos8,
		 contaparam.digitos9  
 INTO :niveles,:dig[1],:dig[2],:dig[3],:dig[4],:dig[5],:dig[6],:dig[7],   
		:dig[8],:dig[9]  FROM contaparam  
WHERE contaparam.ejercicio = :anyo
AND  	contaparam.empresa 	= :codigo_empresa;
			
dw_niveles.reset()

FOR i=1 TO niveles
	dw_niveles.insertrow(i)
	dw_niveles.SetItem(i,"nivel",i)
	dw_niveles.SetItem(i,"digitos",dig[i])
	dw_niveles.SetItem(i,"marca","S")
NEXT

dw_niveles.visible = TRUE

end subroutine

public function datetime dias_mes (integer el_mes, integer el_anyo);int 		resto,dia
DateTime	fecha

CHOOSE CASE  el_mes
	CASE 1,3,5,7,8,10,12
		dia = 31
	CASE 4,6,9,11
		dia = 30
	CASE 2
		resto = mod(el_anyo,4) 
		IF resto = 0 THEN
			dia = 29
		ELSE
			dia = 28
		END IF
end CHOOSE

fecha = DateTime(Date(String(dia)+"/"+String(el_mes)+"/"+String(el_anyo)))

RETURN fecha
end function

public subroutine f_cargar2 (datawindow dw_data);DataStore data
String  	sel,cuenta,origend,origenh,fechin
String  	c[],antec[],n[]
Dec 		j,r,xdebe,xhaber,niveles,g
Dec		debe[],haber[],debeper[],haberper[],dig[]
Dec 		h = 0
Integer	mes_apunte,mesi,anyi,digi
DateTime	fecapu,fperdesde,fperhasta,fejedesde,fejehasta

fejedesde = DateTime(Date(em_fechadesde.text))
fejehasta = DateTime(Date(em_fechahasta.text))
mesi	= Month(Date(em_fechahasta.text))
anyi	= Year(Date(em_fechahasta.text))
fechin = '01/'+String(mesi)+'/'+String(anyi)
fperdesde = DateTime(Date(fechin))
fperhasta = dias_mes(Month(Date(em_fechahasta.text)),Year(Date(em_fechahasta.text)))

string origen_malo

// Controlamos los origenes contables
CHOOSE CASE ddlb_origen.text	
	CASE "Antes Explotación"
		origend = '0'
		origenh = '96'
		origen_malo = "'" + "102" + "','" + "100" + "'"
	CASE "Antes Cierre"
		origend = '0'
		origenh = '97'
		origen_malo = "'" + "100" + "'"
	CASE "Todos"
		origend = '0'
		origenh = '99999'
		origen_malo = "''"
END CHOOSE

// Buscamos el nivel mas bajo para hacer los totales en datawindow
j = dw_niveles.RowCount()

FOR r = 1 TO j
	IF dw_niveles.GetItemString(r,"marca") = "S" THEN
		digi = dw_niveles.GetItemNumber(r,"digitos")
		EXIT
	END IF
NEXT

IF digi = 0 THEN
	f_mensaje("ERROR","Debe marcar algún nivel contable")
	RETURN
END IF
dw_data.SetTransObject(SQLCA)
dw_data.Reset()
dw_data.Retrieve(codigo_empresa,fperdesde,fperhasta,fejedesde,fejehasta,moneda_emp,Dec(em_pagina.text),digi)
dw_data.SetRedraw(FALSE)

j = dw_niveles.RowCount()

FOR r = 1 TO j
	n[r] = dw_niveles.GetItemString(r,"marca")
NEXT

f_mensaje_proceso("Procesando",1,100)

sel = "Select cuenta,contaapun.fapunte, sum(contaapun.debe) debe,sum(contaapun.haber) haber " +&
 " FROM contaapun  " +&
 " WHERE ( contaapun.ejercicio = " + String(anyo) +") "+&
 "	AND   ( contaapun.empresa = '"+ codigo_empresa + "' ) "+&
 "	AND   ( contaapun.origen not in ("+ origen_malo +") "+&           
 "	AND   ( contaapun.fapunte BETWEEN '"+ String(Datetime(Date(em_fechadesde.text)),"dd/mm/yy") + "' AND '" + String(Datetime(Date(em_fechahasta.text)),"dd/mm/yy") +"') "+&
 "	AND   ( contaapun.cuenta BETWEEN '"+ Trim(em_cuentadesde.text) + "' AND '" + Trim(em_cuentahasta.text) +"') "+&
 " GROUP BY cuenta,fapunte"+&
 " ORDER BY cuenta "

//data = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, data)

SELECT contaparam.niveles,contaparam.digitos1,contaparam.digitos2,   
       contaparam.digitos3,contaparam.digitos4,contaparam.digitos5,   
       contaparam.digitos6,contaparam.digitos7,contaparam.digitos8,   
       contaparam.digitos9  
    INTO :niveles,:dig[1],:dig[2],:dig[3],:dig[4],:dig[5],   
         :dig[6],:dig[7],:dig[8],:dig[9]      FROM contaparam  
WHERE contaparam.ejercicio = :anyo
AND   contaparam.empresa   = :codigo_empresa;

FOR g = 1 To niveles
	SetNUll(antec[g])
	debe[g]  = 0
	haber[g] = 0
	debeper[g]  = 0
	haberper[g] = 0
Next

r = data.RowCount()

For j = 1 To r + 1
	
	IF j < r + 1 THEN
		cuenta 	= data.GetItemSTring(j,"cuenta")
		xdebe 	= data.GetItemNumber(j,"debe")
		xhaber  	= data.GetItemNUmber(j,"haber")
		fecapu  	= data.GetItemDateTime(j,"fapunte")
	END IF
	For g = 1 To niveles
		IF n[g] ="N" THEN continue
		c[g]     = Mid(cuenta,1,dig[g])
		IF (Not IsNull(antec[g]) and antec[g] <> c[g]) or j = r + 1 Then
			h = h +1
			dw_data.InsertRow(h)	
			dw_data.SetItem(h,"cuenta",antec[g])
			dw_data.SetItem(h,"debe",debe[g])
			dw_data.SetItem(h,"haber",haber[g])
			dw_data.SetItem(h,"debeper",debeper[g])
			dw_data.SetItem(h,"haberper",haberper[g])
			dw_data.SetItem(h,"nombre_cuenta",f_nombre_contaplan(anyo,codigo_empresa,antec[g]))
			debe[g] 		= 0
			haber[g] 	= 0
			debeper[g] 	= 0
			haberper[g] = 0
		END IF
		debe[g]  = debe[g]  + xdebe
		haber[g] = haber[g] + xhaber
		// Acumulamos en periodo si corresponde
		IF Month(Date(fecapu)) = mes THEN
			debeper[g]  = debeper[g]  + xdebe
			haberper[g] = haberper[g] + xhaber
		END IF
	NEXT

	For g =1 To niveles
		IF n[g] ="N" Then continue
		antec[g] = c[g]
	Next
Next

f_mensaje_proceso("Procesando",100,100)
dw_data.SetSort("cuenta")
dw_data.Sort()
dw_data.SetRedraw(TRUE)
Destroy(data)

end subroutine

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar
end event

event open;call super::open;str_paramemp	e


// IMPORTANTISIMO : La datawindow de Listado esta debajo del icono de
// salida (la puerta) pues es visible para que vaya mas rapido

This.title = " BALANCE DE SUMAS Y SALDOS"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

mes  = Month(Date(em_fechadesde.text))
anyo = Year(today())

dw_niveles.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
// Carga la datwindow de los niveles contables
f_ayuda_nivel()
dw_niveles.visible = FALSE

e = f_paramemp(codigo_empresa)

moneda_emp = e.moneda_emp

ddlb_origen.text = "Antes Explotación"
em_pagina.text = '0'

f_activar_campo(em_fechadesde)


end event

on w_con_balance.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_cuenta=create gb_cuenta
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.em_cuentadesde=create em_cuentadesde
this.st_2=create st_2
this.em_cuentahasta=create em_cuentahasta
this.dw_1=create dw_1
this.cb_todos=create cb_todos
this.dw_niveles=create dw_niveles
this.ddlb_origen=create ddlb_origen
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_pagina=create em_pagina
this.st_4=create st_4
this.pb_fichero=create pb_fichero
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_cuenta
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.pb_imprimir_preli
this.Control[iCurrent+9]=this.em_cuentadesde
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.em_cuentahasta
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.cb_todos
this.Control[iCurrent+14]=this.dw_niveles
this.Control[iCurrent+15]=this.ddlb_origen
this.Control[iCurrent+16]=this.pb_2
this.Control[iCurrent+17]=this.dw_listado
this.Control[iCurrent+18]=this.em_pagina
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.pb_fichero
this.Control[iCurrent+21]=this.dw_2
end on

on w_con_balance.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_cuenta)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.pb_imprimir_preli)
destroy(this.em_cuentadesde)
destroy(this.st_2)
destroy(this.em_cuentahasta)
destroy(this.dw_1)
destroy(this.cb_todos)
destroy(this.dw_niveles)
destroy(this.ddlb_origen)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_pagina)
destroy(this.st_4)
destroy(this.pb_fichero)
destroy(this.dw_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_balance
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_balance
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_balance
integer y = 20
integer width = 2642
end type

type gb_2 from groupbox within w_con_balance
integer x = 1467
integer y = 172
integer width = 448
integer height = 128
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

type gb_cuenta from groupbox within w_con_balance
integer x = 649
integer y = 116
integer width = 814
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

type em_fechadesde from u_em_campo within w_con_balance
integer x = 18
integer y = 196
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;call super::losefocus;
anyo=year(date(em_fechadesde.text))
if anyo<year(today()) then 
	// FSF 13/04/99
	// Si ya existe una fecha del mismo año que la fecha desde, no cambiar
	If anyo <> year(date(em_fechahasta.text)) then 	em_fechahasta.text=string(date(anyo,12,31))
End If

mes = Month(Date(em_fechadesde.text))
end event

type gb_1 from groupbox within w_con_balance
integer x = 9
integer y = 116
integer width = 631
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_balance
integer x = 1929
integer y = 144
integer width = 297
integer height = 92
integer taborder = 80
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;call super::clicked;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

dw_niveles.visible = FALSE

if anyo2<>anyo then 
	messagebox("Año Incorrecto","El año debe ser el mismo")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

if fechah<date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

IF em_cuentadesde.text = "" THEN
	em_cuentadesde.text = "1"
END IF

IF em_cuentahasta.text = "" THEN
	em_cuentahasta.text = "999999999999999"
END IF

IF em_cuentadesde.text > em_cuentahasta.text THEN
	f_mensaje("ERROR","La cuenta desde mayor que la cuenta hasta")
	f_activar_campo(em_cuentahasta)
	RETURN
END IF

mes = Month(Date(em_fechahasta.text))
f_cargar(dw_1)


end event

type em_fechahasta from u_em_campo within w_con_balance
integer x = 343
integer y = 196
integer width = 279
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

if anyo2<>anyo then 
	messagebox("Año Incorrecto","El año debe ser el mismo")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

if fechah<date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

end event

type st_1 from statictext within w_con_balance
integer x = 297
integer y = 196
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_con_balance
integer x = 2478
integer y = 148
integer width = 187
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\disksave.bmp"
end type

event clicked;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

dw_niveles.visible = FALSE

if anyo2<>anyo then 
	messagebox("Año Incorrecto","El año debe ser el mismo")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

if fechah<date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

IF em_cuentadesde.text = "" THEN
	em_cuentadesde.text = "1"
END IF

IF em_cuentahasta.text = "" THEN
	em_cuentahasta.text = "999999999999999"
END IF

IF em_cuentadesde.text > em_cuentahasta.text THEN
	f_mensaje("ERROR","La cuenta desde mayor que la cuenta hasta")
	f_activar_campo(em_cuentahasta)
	RETURN
END IF

mes = Month(Date(em_fechahasta.text))
//f_cargar(dw_listado)
//f_imprimir_datawindow(dw_listado)
//


long registros ,i
int res

registros = dw_1.rowcount()
if registros <= 0 then
	messagebox("No se puede continuar","No hay datos o no se ha consultado")
	return
end if

string cuenta,tit,fichero

dec d1,d2,h1,h2,s1,s2

dw_2.retrieve()


fichero= inputbox("PETICIÓN DE DATOS","Nombre del fichero destino ( sin extensión )","c:\balance","")
IF fichero = "" then
	messagebox("ERROR","Nombre de fichero NO válido")
	return
end if


for i = 1 to registros
	dw_2.insertrow(i)
	cuenta = dw_1.getitemstring(i,"cuenta")
	tit = dw_1.getitemstring(i,"nombre_cuenta")
	d1 = dw_1.getitemnumber(i,"debeper")
	h1 = dw_1.getitemnumber(i,"haberper")
	s1 = dw_1.getitemnumber(i,"saldoper")
	
	d2 = dw_1.getitemnumber(i,"debe")
	h2 = dw_1.getitemnumber(i,"haber")
	s2 = dw_1.getitemnumber(i,"saldo")
	
	
	dw_2.setitem(i,"cuenta",cuenta)
	dw_2.setitem(i,"titulo",tit)
	dw_2.setitem(i,"d1",d1)
	dw_2.setitem(i,"h1",h1)
	dw_2.setitem(i,"s1",s1)
	dw_2.setitem(i,"d2",d2)
	dw_2.setitem(i,"h2",h2)
	dw_2.setitem(i,"s2",s2)
	
next



res = dw_2.saveas(fichero + ".xls",excel!,false)
if res = -1 then f_mensaje("ERROR","Al grabar el fichero")
if res = 1 then f_mensaje("CORRECTO","La información se ha grabado correctamente ")


end event

type em_cuentadesde from u_em_campo within w_con_balance
integer x = 667
integer y = 196
integer width = 357
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type st_2 from statictext within w_con_balance
integer x = 1029
integer y = 168
integer width = 64
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cuentahasta from u_em_campo within w_con_balance
integer x = 1093
integer y = 196
integer width = 357
integer taborder = 50
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type dw_1 from datawindow within w_con_balance
integer x = 5
integer y = 324
integer width = 2866
integer height = 1604
string dataobject = "dw_con_balance"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_todos from commandbutton within w_con_balance
integer x = 1472
integer y = 144
integer width = 439
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Nivel"
end type

event clicked;f_ayuda_nivel()
end event

type dw_niveles from datawindow within w_con_balance
boolean visible = false
integer x = 1458
integer y = 188
integer width = 448
integer height = 472
boolean bringtotop = true
string dataobject = "dw_niveles_contables"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;String marca

CHOOSE CASE f_objeto_datawindow(This)
	CASE "marca"
		
	marca = This.GetItemString(row,"marca")
		// Cambiamos su valor
	IF marca = "S" then
		marca = "N"
	ELSE
		marca = "S"
	END IF
	This.SetItem(row,"marca",marca)
END CHOOSE


if dwo.name = "salir" then
	dw_niveles.visible = false
	
end if
end event

type ddlb_origen from dropdownlistbox within w_con_balance
integer x = 1481
integer y = 212
integer width = 416
integer height = 304
integer taborder = 60
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Antes Explotación","Antes Cierre","Todos"}
borderstyle borderstyle = stylelowered!
end type

type pb_2 from upb_salir within w_con_balance
integer x = 2711
integer y = 24
integer width = 128
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type dw_listado from datawindow within w_con_balance
integer x = 2738
integer y = 52
integer width = 69
integer height = 40
string dataobject = "report_balance"
end type

type em_pagina from u_em_campo within w_con_balance
boolean visible = false
integer x = 2528
integer y = 132
integer width = 133
integer taborder = 70
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type st_4 from statictext within w_con_balance
boolean visible = false
integer x = 2281
integer y = 140
integer width = 242
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Ult.Pág:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_fichero from picturebutton within w_con_balance
integer x = 2263
integer y = 148
integer width = 183
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

dw_niveles.visible = FALSE

if anyo2<>anyo then 
	messagebox("Año Incorrecto","El año debe ser el mismo")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

if fechah<date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

IF em_cuentadesde.text = "" THEN
	em_cuentadesde.text = "1"
END IF

IF em_cuentahasta.text = "" THEN
	em_cuentahasta.text = "999999999999999"
END IF

IF em_cuentadesde.text > em_cuentahasta.text THEN
	f_mensaje("ERROR","La cuenta desde mayor que la cuenta hasta")
	f_activar_campo(em_cuentahasta)
	RETURN
END IF

mes = Month(Date(em_fechahasta.text))
f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type dw_2 from datawindow within w_con_balance
boolean visible = false
integer x = 1138
integer y = 348
integer width = 494
integer height = 360
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_balance_fichero"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

