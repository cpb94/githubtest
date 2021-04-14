$PBExportHeader$w_int_traspaso_contaplan.srw
forward
global type w_int_traspaso_contaplan from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_traspaso_contaplan
end type
type uo_ejercicio_origen from u_ejercicio within w_int_traspaso_contaplan
end type
type uo_ejercicio_destino from u_ejercicio within w_int_traspaso_contaplan
end type
type st_1 from statictext within w_int_traspaso_contaplan
end type
type st_2 from statictext within w_int_traspaso_contaplan
end type
type cb_4 from u_boton within w_int_traspaso_contaplan
end type
type cb_1 from u_boton within w_int_traspaso_contaplan
end type
type st_3 from statictext within w_int_traspaso_contaplan
end type
type st_4 from statictext within w_int_traspaso_contaplan
end type
type st_5 from statictext within w_int_traspaso_contaplan
end type
type cb_2 from u_boton within w_int_traspaso_contaplan
end type
type cb_3 from u_boton within w_int_traspaso_contaplan
end type
type st_6 from statictext within w_int_traspaso_contaplan
end type
end forward

global type w_int_traspaso_contaplan from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2889
integer height = 1396
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_ejercicio_origen uo_ejercicio_origen
uo_ejercicio_destino uo_ejercicio_destino
st_1 st_1
st_2 st_2
cb_4 cb_4
cb_1 cb_1
st_3 st_3
st_4 st_4
st_5 st_5
cb_2 cb_2
cb_3 cb_3
st_6 st_6
end type
global w_int_traspaso_contaplan w_int_traspaso_contaplan

type variables
integer ejercicio_origen,ejercicio_destino
end variables

event open;call super::open;This.title = " PROCESO TRASPASO DE UN EJERCICIO A OTRO"
f_activar_campo(uo_ejercicio_origen.em_ejercicio)


end event

on w_int_traspaso_contaplan.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_ejercicio_origen=create uo_ejercicio_origen
this.uo_ejercicio_destino=create uo_ejercicio_destino
this.st_1=create st_1
this.st_2=create st_2
this.cb_4=create cb_4
this.cb_1=create cb_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_ejercicio_origen
this.Control[iCurrent+3]=this.uo_ejercicio_destino
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.st_6
end on

on w_int_traspaso_contaplan.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_ejercicio_origen)
destroy(this.uo_ejercicio_destino)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_6)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_traspaso_contaplan
integer x = 1527
integer y = 320
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_traspaso_contaplan
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_traspaso_contaplan
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_int_traspaso_contaplan
integer x = 2715
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type uo_ejercicio_origen from u_ejercicio within w_int_traspaso_contaplan
event destroy ( )
integer x = 133
integer y = 228
integer width = 645
integer taborder = 50
end type

on uo_ejercicio_origen.destroy
call u_ejercicio::destroy
end on

type uo_ejercicio_destino from u_ejercicio within w_int_traspaso_contaplan
event destroy ( )
integer x = 855
integer y = 228
integer taborder = 60
boolean bringtotop = true
end type

on uo_ejercicio_destino.destroy
call u_ejercicio::destroy
end on

type st_1 from statictext within w_int_traspaso_contaplan
integer x = 407
integer y = 144
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Origen"
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_traspaso_contaplan
integer x = 1129
integer y = 144
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Destino"
boolean focusrectangle = false
end type

type cb_4 from u_boton within w_int_traspaso_contaplan
event clicked pbm_bnclicked
integer x = 155
integer y = 976
integer height = 92
integer taborder = 30
string text = "Procesar"
end type

event clicked;call super::clicked;Dec{0} var_ejercicio,var_nivel,r,r1,numero,bien
String var_coste,var_cuenta,var_titulo,var_analitica,var_tipocta,var_directos,var_empresa

bien = 0

ejercicio_origen = Dec(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino = Dec(uo_ejercicio_destino.em_ejercicio.text)

Select Count(*) Into :numero From contaparam
Where  empresa    =  :codigo_empresa
And    ejercicio  =  :ejercicio_destino;
IF IsNull(numero) Then numero = 0
IF numero =0 Then
	f_mensaje("No se puede continuar","El Ejercicio destino no ha sido creado")
	f_activar_campo(uo_ejercicio_destino.em_ejercicio)
	Return
END IF


Select Count(*) Into :numero From contarecur
Where  contarecur.ejercicio = :ejercicio_destino
And    contarecur.empresa   = :codigo_empresa;
IF IsNull(numero) Then numero = 0
IF numero <> 0 Then
		f_mensaje("No se puede continuar","Existen asientos recurrentes en el ejercicio destino")
		f_activar_campo(uo_ejercicio_destino.em_ejercicio)
		Return
END IF

// Si no hay asientos recurrentes en el destino

ejercicio_origen = 	integer(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino =	integer(uo_ejercicio_destino.em_ejercicio.text)


int resultado3,resultado4
resultado3 = f_copia_as_rec(ejercicio_origen,ejercicio_destino)

resultado4 = f_copia_lin_asrec(ejercicio_origen,ejercicio_destino)

if (resultado3 = 1 ) and (resultado4 = 1)then
	f_mensaje("Bien","Se copiaron correctamente los asientos recurrentes ")
   commit;

else
	if (resultado3 = -1) or (resultado4 = -1) then 
		f_mensaje("Atención","No se copiaron los asientos recurrentes, " + &
									"error al consultar la Base de Datos ")
	end if
	if resultado3 = 0 then f_mensaje("Atención","No se copiaron los asientos recurrentes, " + &
									"El ejercicio origen no tiene datos ")
	if resultado4 = 0 then f_mensaje("Atención","No se copiaron las lineas de los asientos, " + &
									"El ejercicio origen no tiene datos ")
	
	
	rollback;
	
end if



end event

type cb_1 from u_boton within w_int_traspaso_contaplan
integer x = 155
integer y = 592
integer height = 92
integer taborder = 10
boolean bringtotop = true
string text = "Procesar"
end type

event clicked;call super::clicked;Dec{0} var_ejercicio,var_nivel,r,r1,numero,bien
String var_coste,var_cuenta,var_titulo,var_analitica,var_tipocta,var_directos,var_empresa

bien = 0

ejercicio_origen = Dec(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino = Dec(uo_ejercicio_destino.em_ejercicio.text)

Select Count(*) Into :numero From contaparam
Where  empresa    =  :codigo_empresa
And    ejercicio  =  :ejercicio_destino;
IF IsNull(numero) Then numero = 0
IF numero =0 Then
	f_mensaje("No se puede continuar","El Ejercicio destino no ha sido creado")
	f_activar_campo(uo_ejercicio_destino.em_ejercicio)
	Return
END IF

// Comprobamos si existen cuantas en el ejercicio destino

int opci

Select Count(*) Into :numero From contaplan
Where  contaplan.ejercicio = :ejercicio_destino
And    contaplan.empresa   = :codigo_empresa;
IF IsNull(numero) Then numero = 0
IF numero <> 0 Then
		opci = messagebox("Atención","Existen cuentas en el ejercicio destino, ¿ Desea reemplazarlas ?",question!,yesno!,2)
		f_activar_campo(uo_ejercicio_destino.em_ejercicio)
		
END IF

if opci = 1 then
	// Borramos las cuentas del plan del ejercicio destino
	Delete from contaplan 
	Where  contaplan.ejercicio = :ejercicio_destino
	And    contaplan.empresa   = :codigo_empresa;
	
else
	f_mensaje("Atención","Las cuentas no se han copiado")
	return
end if


// Copiamos la cuentas en el ejercicio destino

ejercicio_origen = 	integer(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino =	integer(uo_ejercicio_destino.em_ejercicio.text)


setpointer(hourglass!)

int resultado2
resultado2 = f_copiar_plan(ejercicio_origen,ejercicio_destino)

setpointer(arrow!)
if resultado2 = 1 then
	f_mensaje("Atención","Se han copiado correctamente las cuentas ")
   commit;

else
	if resultado2 = -1 then f_mensaje("Atención","No se copiaron las cuentas, " + &
									"error al consultar la Base de Datos ")
	
	if resultado2 = 0 then f_mensaje("Atención","No se copiaron las cuentas del plan, " + &
									"El ejercicio origen no tiene datos ")
	
	rollback;
	
end if



end event

type st_3 from statictext within w_int_traspaso_contaplan
integer x = 681
integer y = 576
integer width = 1015
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Traspaso plan de cuentas "
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_traspaso_contaplan
integer x = 681
integer y = 712
integer width = 969
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Traspaso libros de IVA "
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_traspaso_contaplan
integer x = 681
integer y = 844
integer width = 969
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Traspaso tipos de IVA "
boolean focusrectangle = false
end type

type cb_2 from u_boton within w_int_traspaso_contaplan
event clicked pbm_bnclicked
integer x = 160
integer y = 716
integer height = 92
integer taborder = 40
boolean bringtotop = true
string text = "Procesar"
end type

event clicked;call super::clicked;Dec{0} var_ejercicio,var_nivel,r,r1,numero,bien
String var_coste,var_cuenta,var_titulo,var_analitica,var_tipocta,var_directos,var_empresa

bien = 0

ejercicio_origen = Dec(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino = Dec(uo_ejercicio_destino.em_ejercicio.text)

// Comprobamos si existe el ejercicio destino

Select Count(*) Into :numero From contaparam
Where  empresa    =  :codigo_empresa
And    ejercicio  =  :ejercicio_destino;
IF IsNull(numero) Then numero = 0
IF numero =0 Then
	f_mensaje("No se puede continuar","El Ejercicio destino no ha sido creado")
	f_activar_campo(uo_ejercicio_destino.em_ejercicio)
	Return
END IF


// Comprobamos si ya hay libros de iva

int opci

Select Count(*) Into :numero From contalibros
Where  contalibros.ejercicio = :ejercicio_destino
And    contalibros.empresa   = :codigo_empresa;
IF IsNull(numero) Then numero = 0
IF numero <> 0 Then
		opci = messagebox("Atención","Existen libros de iva en el ejercicio destino. ¿ Desea reemplazarlos ?",question!,yesno!,2)
		f_activar_campo(uo_ejercicio_destino.em_ejercicio)
		
END IF

if opci = 1 then
	// Borramos los que ya estuvieran en el destino
	delete from contalibros
	where (contalibros.ejercicio = :ejercicio_destino)	and 
			(contalibros.empresa = :codigo_empresa);
	
else
	f_mensaje("Atención","No se han copiado")
	return
		
end if

// Copiamos los libros

ejercicio_origen = 	integer(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino =	integer(uo_ejercicio_destino.em_ejercicio.text)


int resultado2
resultado2 = f_copiar_libros_iva(ejercicio_origen,ejercicio_destino)


if resultado2 = 1 then
	f_mensaje("Atención","Se copiaron correctamente los libros de IVA ")
   commit;

else
	if resultado2 = -1 then f_mensaje("Atención","No se copiaron los libros de IVA, " + &
									"error al consultar la Base de Datos ")
	
	if resultado2 = 0 then f_mensaje("Atención","No se copiaron los libros de IVA, " + &
									"El ejercicio origen no tiene datos ")
	
	rollback;
	
end if



end event

type cb_3 from u_boton within w_int_traspaso_contaplan
event clicked pbm_bnclicked
integer x = 155
integer y = 844
integer height = 92
integer taborder = 20
boolean bringtotop = true
string text = "Procesar"
end type

event clicked;call super::clicked;Dec{0} var_ejercicio,var_nivel,r,r1,numero,bien
String var_coste,var_cuenta,var_titulo,var_analitica,var_tipocta,var_directos,var_empresa

bien = 0

ejercicio_origen = Dec(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino = Dec(uo_ejercicio_destino.em_ejercicio.text)

// Comprobamos si existe el ejercicio destino

Select Count(*) Into :numero From contaparam
Where  empresa    =  :codigo_empresa
And    ejercicio  =  :ejercicio_destino;
IF IsNull(numero) Then numero = 0
IF numero =0 Then
	f_mensaje("No se puede continuar","El Ejercicio destino no ha sido creado")
	f_activar_campo(uo_ejercicio_destino.em_ejercicio)
	Return
END IF


// Comprobamos si ya existen tipos de iva en el ejercicio destino
int opci

Select Count(*) Into :numero From contaiva
Where  contaiva.ejercicio = :ejercicio_destino
And    contaiva.empresa   = :codigo_empresa;
IF IsNull(numero) Then numero = 0
IF numero <> 0 Then		
		opci = messagebox("Atención","Existen tipos de iva en el ejercicio destino. ¿ Desea reemplazarlos ?",question!,yesno!,2)
		f_activar_campo(uo_ejercicio_destino.em_ejercicio)
		
END IF

if opci = 1 then 
	// Borramos los que ya estuvieran en el destino
	delete from contaiva
	where (contaiva.ejercicio = :ejercicio_destino)	and 
			(contaiva.empresa = :codigo_empresa);
	
else
	// No continuamos
	return
end if


// copiamos los del ejercicio anterior

ejercicio_origen = 	integer(uo_ejercicio_origen.em_ejercicio.text)
ejercicio_destino =	integer(uo_ejercicio_destino.em_ejercicio.text)


int resultado3
resultado3 = f_cop_tip_iva_gno(codigo_empresa,ejercicio_origen,ejercicio_destino,'contaiva')//f_cop_tip_iva(ejercicio_origen,ejercicio_destino)


if resultado3 = 1 then
	f_mensaje("Atención","Se copiaron correctamente los tipos de IVA ")
   commit;

else
	if resultado3 = -1 then f_mensaje("Atención","No se copiaron los tipos de IVA, " + &
									"error al consultar la Base de Datos ")
	
	if resultado3 = 0 then f_mensaje("Atención","No se copiaron los tipos de IVA, " + &
									"El ejercicio origen no tiene datos ")
	
	rollback;
	
end if



end event

type st_6 from statictext within w_int_traspaso_contaplan
integer x = 681
integer y = 988
integer width = 1184
integer height = 76
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Traspaso asientos recurrentes "
boolean focusrectangle = false
end type

