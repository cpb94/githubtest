$PBExportHeader$w_con_saldo_meses.srw
$PBExportComments$€
forward
global type w_con_saldo_meses from w_int_con_empresa
end type
type gb_cuenta from groupbox within w_con_saldo_meses
end type
type em_fechadesde from u_em_campo within w_con_saldo_meses
end type
type gb_1 from groupbox within w_con_saldo_meses
end type
type cb_consulta from u_boton within w_con_saldo_meses
end type
type em_fechahasta from u_em_campo within w_con_saldo_meses
end type
type st_1 from statictext within w_con_saldo_meses
end type
type pb_imprimir_preli from picturebutton within w_con_saldo_meses
end type
type em_cuentadesde from u_em_campo within w_con_saldo_meses
end type
type st_2 from statictext within w_con_saldo_meses
end type
type em_cuentahasta from u_em_campo within w_con_saldo_meses
end type
type dw_1 from datawindow within w_con_saldo_meses
end type
type cb_todos from commandbutton within w_con_saldo_meses
end type
type dw_niveles from datawindow within w_con_saldo_meses
end type
type ddlb_origen from dropdownlistbox within w_con_saldo_meses
end type
type st_3 from statictext within w_con_saldo_meses
end type
type pb_2 from upb_salir within w_con_saldo_meses
end type
type dw_listado from datawindow within w_con_saldo_meses
end type
end forward

global type w_con_saldo_meses from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2967
integer height = 2140
string title = "Consulta de Movimientos"
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
st_3 st_3
pb_2 pb_2
dw_listado dw_listado
end type
global w_con_saldo_meses w_con_saldo_meses

type variables
Integer mes,anyo
String moneda_emp
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_ayuda_nivel ()
public function datetime dias_mes (integer el_mes, integer el_anyo)
public function integer f_dias_mes (integer el_mes, integer el_anyo)
end prototypes

public subroutine f_cargar (datawindow dw_data);DataStore data
String  	sel,cuenta,origend,origenh,fechin
String  	c[],antec[],n[]
Dec 		j,r,saldo,niveles,g
Dec		debe[],haber[],debeper[],haberper[],dig[]
dec		total_saldo[],saldo1[],saldo2[],saldo3[],saldo4[],saldo5[]
dec		saldo6[],saldo7[],saldo8[],saldo9[],saldo10[],saldo11[],saldo12[]
Dec 		h = 0
Integer	mes_apunte,mesi,anyi,digi,mes_inicio
DateTime	fecapu,fperdesde,fperhasta,fejedesde,fejehasta
DEC		ejer_desde,ejer_hasta

fejedesde = DateTime(Date(em_fechadesde.text))
fejehasta = DateTime(Date(em_fechahasta.text))
mesi	= Month(Date(em_fechahasta.text))
anyi	= Year(Date(em_fechahasta.text))
fechin = '01/'+String(mesi)+'/'+String(anyi)
fperdesde = DateTime(Date(fechin))
fperhasta = dias_mes(Month(Date(em_fechahasta.text)),Year(Date(em_fechahasta.text)))

mes_inicio = month(date(em_fechadesde.text))
ejer_desde = year(date(em_fechadesde.text))
ejer_hasta = year(date(em_fechahasta.text))

// Controlamos los origenes contables
CHOOSE CASE ddlb_origen.text	
	CASE "Antes Explotación"
		origend = '0'
		origenh = '96'
	CASE "Antes Cierre"
		origend = '0'
		origenh = '97'
	CASE "Todos"
		origend = '0'
		origenh = '99999'
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
dw_data.Retrieve(codigo_empresa,fperdesde,fperhasta,fejedesde,fejehasta,moneda_emp,digi,mes_inicio,Trim(em_cuentadesde.text),Trim(em_cuentahasta.text))
dw_data.SetRedraw(FALSE)

j = dw_niveles.RowCount()

FOR r = 1 TO j
	n[r] = dw_niveles.GetItemString(r,"marca")
NEXT

f_mensaje_proceso("Procesando",1,100)

sel = "Select cuenta,contaapun.fapunte, sum(contaapun.debe - contaapun.haber) saldo  " +&
 " FROM contaapun  " +&
 " WHERE ( contaapun.ejercicio between " + String(ejer_desde)+ " and " +string(ejer_hasta) +") "+&
 "	AND   ( contaapun.empresa = '"+ codigo_empresa + "' ) "+&
 "	AND   (( contaapun.origen BETWEEN '"+ String(origend) + "' AND '" + String(origenh) +"') "+&
           " OR contaapun.origen = '99' OR contaapun.origen = '100')" +&   
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
	total_saldo[g]	=	0
	saldo1[g]  	= 0
	saldo2[g]  	= 0
	saldo3[g]  	= 0
	saldo4[g]  	= 0
	saldo5[g]  	= 0
	saldo6[g]  	= 0
	saldo7[g]  	= 0
	saldo8[g]  	= 0
	saldo9[g]  	= 0
	saldo10[g]  = 0
	saldo11[g]  = 0
	saldo12[g]  = 0
Next

r = data.RowCount()

For j = 1 To r + 1
	
	IF j < r + 1 THEN
		cuenta 	= data.GetItemSTring(j,"cuenta")
		saldo 	= data.GetItemNumber(j,"saldo")
		fecapu  	= data.GetItemDateTime(j,"fapunte")
	END IF
	For g = 1 To niveles
		IF n[g] ="N" THEN continue
		c[g]     = Mid(cuenta,1,dig[g])
		IF (Not IsNull(antec[g]) and antec[g] <> c[g]) or j = r + 1 Then
			h = h +1
			dw_data.InsertRow(h)	
			dw_data.SetItem(h,"cuenta",antec[g])
			dw_data.SetItem(h,"s",total_saldo[g])
			dw_data.SetItem(h,"s1",saldo1[g])
			dw_data.SetItem(h,"s2",saldo2[g])
			dw_data.SetItem(h,"s3",saldo3[g])
			dw_data.SetItem(h,"s4",saldo4[g])
			dw_data.SetItem(h,"s5",saldo5[g])
			dw_data.SetItem(h,"s6",saldo6[g])
			dw_data.SetItem(h,"s7",saldo7[g])
			dw_data.SetItem(h,"s8",saldo8[g])
			dw_data.SetItem(h,"s9",saldo9[g])
			dw_data.SetItem(h,"s10",saldo10[g])
			dw_data.SetItem(h,"s11",saldo11[g])
			dw_data.SetItem(h,"s12",saldo12[g])
			
			dw_data.SetItem(h,"nombre_cuenta",f_nombre_contaplan(anyo,codigo_empresa,antec[g]))
			
			total_saldo[g] = 	0
			saldo1[g]		=	0
			saldo2[g]		=	0
			saldo3[g]		=	0
			saldo4[g]		=	0
			saldo5[g]		=	0
			saldo6[g]		=	0
			saldo7[g]		=	0
			saldo8[g]		=	0
			saldo9[g]		=	0
			saldo10[g]		=	0
			saldo11[g]		=	0
			saldo12[g]		=	0
			
		END IF
		total_saldo[g]  = total_saldo[g]  + saldo
		
		// Acumulamos en cada mes si corresponde
		IF Month(Date(fecapu)) = mes_inicio THEN
			saldo1[g]  = saldo1[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio + 1 THEN
			saldo2[g]  = saldo2[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 2 THEN
			saldo3[g]  = saldo3[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 3 THEN
			saldo4[g]  = saldo4[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 4 THEN
			saldo5[g]  = saldo5[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 5 THEN
			saldo6[g]  = saldo6[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 6 THEN
			saldo7[g]  = saldo7[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 7 THEN
			saldo8[g]  = saldo8[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 8 THEN
			saldo9[g]  = saldo9[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 9 THEN
			saldo10[g]  = saldo10[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 10 THEN
			saldo11[g]  = saldo11[g]  + saldo			
		END IF
		IF Month(Date(fecapu)) = mes_inicio  + 11 THEN
			saldo12[g]  = saldo12[g]  + saldo			
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

public function integer f_dias_mes (integer el_mes, integer el_anyo);int 		resto,dia


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



RETURN dia
end function

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar
end event

event open;call super::open;str_paramemp	e
int dec_moneda

// IMPORTANTISIMO : La datawindow de Listado esta debajo del icono de
// salida (la puerta) pues es visible para que vaya mas rapido

This.title = " EXTRACTO DE CUENTAS POR MESES"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

mes  = Month(Date(em_fechadesde.text))
anyo = Year(today())

dw_niveles.SetTransObject(SQLCA)

// Carga la datwindow de los niveles contables
f_ayuda_nivel()
dw_niveles.visible = FALSE

e = f_paramemp(codigo_empresa)

moneda_emp = e.moneda_emp

ddlb_origen.text = "Antes Explotación"


f_activar_campo(em_fechadesde)

dec_moneda = f_decimales_moneda(e.moneda_emp)
f_mascara_columna(dw_1,"s",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s1",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s2",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s3",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s4",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s5",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s6",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s7",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s8",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s9",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s10",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s11",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"s12",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_1,"t",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t1",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t2",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t3",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t4",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t5",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t6",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t7",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t8",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t9",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t10",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t11",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"t12",f_mascara_decimales(dec_moneda))



f_mascara_columna(dw_listado,"s",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s1",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s2",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s3",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s4",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s5",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s6",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s7",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s8",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s9",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s10",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s11",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"s12",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_listado,"t",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t1",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t2",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t3",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t4",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t5",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t6",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t7",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t8",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t9",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t10",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t11",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"t12",f_mascara_decimales(dec_moneda))




end event

on w_con_saldo_meses.create
int iCurrent
call super::create
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
this.st_3=create st_3
this.pb_2=create pb_2
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_cuenta
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.pb_imprimir_preli
this.Control[iCurrent+8]=this.em_cuentadesde
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_cuentahasta
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cb_todos
this.Control[iCurrent+13]=this.dw_niveles
this.Control[iCurrent+14]=this.ddlb_origen
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.pb_2
this.Control[iCurrent+17]=this.dw_listado
end on

on w_con_saldo_meses.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
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
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.dw_listado)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_saldo_meses
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_saldo_meses
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_saldo_meses
integer y = 20
integer width = 2642
end type

type gb_cuenta from groupbox within w_con_saldo_meses
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

type em_fechadesde from u_em_campo within w_con_saldo_meses
integer x = 18
integer y = 196
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modified;call super::modified;int a_mes,a_anyo,n_dia,n_mes,n_anyo

a_mes = month(date(em_fechadesde.text))
a_anyo = year(date(em_fechadesde.text))


if a_mes <> 1 then
	n_mes = a_mes - 1
	n_anyo = a_anyo + 1
else
	n_mes = 12	
	n_anyo = a_anyo  
end if

n_dia = f_dias_mes(n_mes,n_anyo)

	

em_fechahasta.text = string(n_dia) + "/" + string(n_mes) + "/" + string(n_anyo)
end event

type gb_1 from groupbox within w_con_saldo_meses
integer x = 9
integer y = 116
integer width = 640
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

type cb_consulta from u_boton within w_con_saldo_meses
integer x = 2350
integer y = 164
integer width = 334
integer height = 92
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;call super::clicked;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

dw_niveles.visible = FALSE

dw_1.visible = false

if anyo2 <>anyo then 
	if anyo + 1 <> anyo2 then
		messagebox("Fecha hasta incorrecta","Han de ser años consecutivos")
		em_fechahasta.text=string(date(anyo,12,31))
		f_activar_campo(em_fechahasta)
		RETURN
	end if
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
if dw_1.rowcount() > 0 then
	dw_1.visible = true
else
	dw_1.visible = false	
end if

end event

type em_fechahasta from u_em_campo within w_con_saldo_meses
integer x = 352
integer y = 196
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_saldo_meses
integer x = 297
integer y = 176
integer width = 59
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

type pb_imprimir_preli from picturebutton within w_con_saldo_meses
integer x = 2761
integer y = 164
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

dw_niveles.visible = FALSE

if anyo2 <>anyo then 
	if anyo + 1 <> anyo2 then
		messagebox("Fecha hasta incorrecta","Han de ser años consecutivos")
		em_fechahasta.text=string(date(anyo,12,31))
		f_activar_campo(em_fechahasta)
		RETURN
	end if
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

type em_cuentadesde from u_em_campo within w_con_saldo_meses
integer x = 667
integer y = 196
integer width = 357
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type st_2 from statictext within w_con_saldo_meses
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

type em_cuentahasta from u_em_campo within w_con_saldo_meses
integer x = 1093
integer y = 196
integer width = 357
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type dw_1 from datawindow within w_con_saldo_meses
boolean visible = false
integer x = 5
integer y = 324
integer width = 2866
integer height = 1584
string dataobject = "dw_con_saldo_meses"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_todos from commandbutton within w_con_saldo_meses
integer x = 1458
integer y = 124
integer width = 443
integer height = 68
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

type dw_niveles from datawindow within w_con_saldo_meses
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
end event

type ddlb_origen from dropdownlistbox within w_con_saldo_meses
integer x = 1902
integer y = 188
integer width = 366
integer height = 304
integer taborder = 50
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
end type

type st_3 from statictext within w_con_saldo_meses
integer x = 1902
integer y = 124
integer width = 361
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Orígenes"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_saldo_meses
integer x = 2761
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type dw_listado from datawindow within w_con_saldo_meses
integer x = 2779
integer y = 52
integer width = 69
integer height = 40
string dataobject = "report_con_saldo_meses"
end type

