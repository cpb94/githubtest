$PBExportHeader$w_mant_venfacprev_estacionalidad.srw
forward
global type w_mant_venfacprev_estacionalidad from wi_mvent_con_empresa
end type
type dw_2 from u_datawindow within w_mant_venfacprev_estacionalidad
end type
type dw_prev_familias_update from datawindow within w_mant_venfacprev_estacionalidad
end type
end forward

global type w_mant_venfacprev_estacionalidad from wi_mvent_con_empresa
integer width = 4279
integer height = 2096
dw_2 dw_2
dw_prev_familias_update dw_prev_familias_update
end type
global w_mant_venfacprev_estacionalidad w_mant_venfacprev_estacionalidad

type variables
dec id_porcentaje1,id_porcentaje2,id_porcentaje3,id_porcentaje4,id_porcentaje5,id_porcentaje6
dec id_porcentaje7,id_porcentaje8,id_porcentaje9,id_porcentaje10,id_porcentaje11,id_porcentaje12
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,Integer(sle_valor.Text))

dw_2.Retrieve(codigo_empresa,Integer(sle_valor.Text))

dw_prev_familias_update.Retrieve(codigo_empresa,Integer(sle_valor.Text))
end subroutine

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "venfacprev_estacionalidad"

f_control()

CALL Super::ue_recuperar
end event

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento Estacionalidad Previsiones"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana

dw_2.settransobject(sqlca)
dw_prev_familias_update.settransobject(sqlca)

sle_valor.text=String(year(today()))  

event ue_recuperar(0,0)	

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		event ue_recuperar(0,0)
	END IF
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"ejercicio",Integer(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"porcentaje1",0)
dw_1.setitem(dw_1.getrow(),"porcentaje2",0)
dw_1.setitem(dw_1.getrow(),"porcentaje3",0)
dw_1.setitem(dw_1.getrow(),"porcentaje4",0)
dw_1.setitem(dw_1.getrow(),"porcentaje5",0)
dw_1.setitem(dw_1.getrow(),"porcentaje6",0)
dw_1.setitem(dw_1.getrow(),"porcentaje7",0)
dw_1.setitem(dw_1.getrow(),"porcentaje8",0)
dw_1.setitem(dw_1.getrow(),"porcentaje9",0)
dw_1.setitem(dw_1.getrow(),"porcentaje10",0)
dw_1.setitem(dw_1.getrow(),"porcentaje11",0)
dw_1.setitem(dw_1.getrow(),"porcentaje12",0)


end event

on w_mant_venfacprev_estacionalidad.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_prev_familias_update=create dw_prev_familias_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_prev_familias_update
end on

on w_mant_venfacprev_estacionalidad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_prev_familias_update)
end on

event ue_actualiza_dw;
if dw_prev_familias_update.update(true) = 1 then
	call super::ue_actualiza_dw
else
	rollback;
	messagebox("Error","No se actualiza.")
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_venfacprev_estacionalidad
integer x = 18
integer y = 184
integer width = 4233
integer height = 280
string dataobject = "dw_mant_venfacprev_estacionalidad"
end type

event dw_1::clicked;call super::clicked;//str_parametros lstr_param
//
//lstr_param.i_nargumentos    = 2
//lstr_param.s_argumentos[1]  = "wi_mant_contaparam"
//CHOOSE CASE f_objeto_datawindow(dw_1)
//  
//CASE 'pb_iva'
//   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipocta_iva")
//   OpenWithParm(wi_mant_contatipocta,lstr_param)  
//
//
//
//END CHOOSE
//
//
//
end event

event dw_1::key;// valor_empresa = TRUE	
// bus_filtro=""
// bus_campo = This.GetColumnName()
// CHOOSE CASE bus_campo
//   CASE "tipocta_iva"
//      bus_titulo     = "VENTANA SELECCION DE TIPO DE CUENTAS "
// 		bus_datawindow = "dw_ayuda_contatipocta"
// 	CASE ELSE
//		SetNull(bus_campo)
// END CHOOSE
 CALL Super::Key
 
end event

event dw_1::rbuttondown;// valor_empresa = TRUE	
// bus_filtro=""
// bus_campo = This.GetColumnName()
// CHOOSE CASE bus_campo
//   CASE "tipocta_iva"
//      bus_titulo     = "VENTANA SELECCION DE TIPO DE CUENTAS "
// 		bus_datawindow = "dw_ayuda_contatipocta"
// 	CASE ELSE
//		SetNull(bus_campo)
// END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::retrieveend;call super::retrieveend;if rowcount > 0 then
	id_porcentaje1 = this.object.porcentaje1[1]
	id_porcentaje2 = this.object.porcentaje2[1]
	id_porcentaje3 = this.object.porcentaje3[1]
	id_porcentaje4 = this.object.porcentaje4[1]
	id_porcentaje5 = this.object.porcentaje5[1]
	id_porcentaje6 = this.object.porcentaje6[1]
	id_porcentaje7 = this.object.porcentaje7[1]
	id_porcentaje8 = this.object.porcentaje8[1]
	id_porcentaje9 = this.object.porcentaje9[1]
	id_porcentaje10 = this.object.porcentaje10[1]
	id_porcentaje11 = this.object.porcentaje11[1]
	id_porcentaje12 = this.object.porcentaje12[1]
else
	id_porcentaje1 = 0
	id_porcentaje2 = 0
	id_porcentaje3 = 0
	id_porcentaje4 = 0
	id_porcentaje5 = 0
	id_porcentaje6 = 0
	id_porcentaje7 = 0
	id_porcentaje8 = 0
	id_porcentaje9 = 0
	id_porcentaje10 = 0
	id_porcentaje11 = 0
	id_porcentaje12 = 0
end if
end event

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case "porcentaje1"	
		id_porcentaje1 = dec(data)	
		
	case "porcentaje2"
		id_porcentaje2 = dec(data)
		
	case "porcentaje3"	
		id_porcentaje3 = dec(data)
		
	case "porcentaje4"
		id_porcentaje4 = dec(data)
		
	case "porcentaje5"
		id_porcentaje5 = dec(data)
		
	case "porcentaje6"
		id_porcentaje6 = dec(data)
		
	case "porcentaje7"
		id_porcentaje7 = dec(data)
		
	case "porcentaje8"
		id_porcentaje8 = dec(data)
		
	case "porcentaje9"
		id_porcentaje9 = dec(data)
		
	case "porcentaje10"
		id_porcentaje10 = dec(data)
		
	case "porcentaje11"
		id_porcentaje11 = dec(data)
		
	case "porcentaje12"
		id_porcentaje12 = dec(data)
		
end choose

long ll_indice,ll_total

ll_total = dw_2.rowcount()

for ll_indice = 1 to ll_total
	dw_2.event itemchanged(ll_indice,dw_2.object.prevision_total,string(dw_2.object.prevision_total[ll_indice]))

next
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_venfacprev_estacionalidad
integer x = 151
integer y = 100
integer width = 302
string text = "Ejercicio:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_venfacprev_estacionalidad
integer x = 2953
integer y = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_venfacprev_estacionalidad
integer x = 3401
integer y = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_venfacprev_estacionalidad
integer x = 480
integer y = 88
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_venfacprev_estacionalidad
integer x = 3849
integer y = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_venfacprev_estacionalidad
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_venfacprev_estacionalidad
integer y = 80
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_venfacprev_estacionalidad
integer width = 2834
end type

type dw_2 from u_datawindow within w_mant_venfacprev_estacionalidad
integer x = 9
integer y = 480
integer width = 4256
integer height = 1456
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Previsiones por familia"
string dataobject = "dw_mant_prev_familias"
end type

event clicked;call super::clicked;if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
end event

event retrieveend;call super::retrieveend;//long   ll_indice,ll_total
//string ls_sel
//
//datastore ds_datos
//
//ls_sel = "
//SELECT familias.codigo, 
//		 familias.descripcion
//FROM   familias
//WHERE  familias.empresa, 
//		 
//
//destroy ds_datos
end event

event itemchanged;call super::itemchanged;dec ld_prevision_total,ld_prevision_mes,ld_prevision_acumulada
long ll_donde

if dwo.name = 'prevision_total' then
	ld_prevision_total     = dec(data)
	ld_prevision_acumulada = 0
	
	//Recalculamos mes a mes
	
	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje1,2)
	
	this.object.prevision1[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje2,2)
	
	this.object.prevision2[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje3,2)
	
	this.object.prevision3[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje4,2)
	
	this.object.prevision4[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje5,2)
	
	this.object.prevision5[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje6,2)
	
	this.object.prevision6[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje7,2)
	
	this.object.prevision7[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje8,2)
	
	this.object.prevision8[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje9,2)
	
	this.object.prevision9[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje10,2)
	
	this.object.prevision10[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = round(( ld_prevision_total / 100 ) * id_porcentaje11,2)
	
	this.object.prevision11[row] = ld_prevision_mes
	
	ld_prevision_acumulada += ld_prevision_mes

	ld_prevision_mes = ld_prevision_total - ld_prevision_acumulada
	
	this.object.prevision12[row] = ld_prevision_mes
	
	//Pasamos los datos a la dw que updatea
	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 1",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 1
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision1[row]
	

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 2",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 2
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision2[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 3",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 3
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision3[row]
	
	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 4",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 4
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision4[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 5",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 5
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision5[row]
	
	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 6",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 6
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision6[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 7",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 7
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision7[row]
	
	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 8",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 8
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision8[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 9",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 9
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision9[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 10",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 10
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision10[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 11",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 11
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision11[row]

	ll_donde = dw_prev_familias_update.find("familia = '"+this.object.familia[row]+"' and mes = 12",1,dw_prev_familias_update.rowcount())
	
	if ll_donde = 0 then
		ll_donde = dw_prev_familias_update.insertrow(0)
		
		dw_prev_familias_update.object.ejercicio[ll_donde]       = this.object.ejercicio[row]
		dw_prev_familias_update.object.mes[ll_donde]             = 12
		dw_prev_familias_update.object.prevision[ll_donde]       = 0
		dw_prev_familias_update.object.prevision_euros[ll_donde] = 0
		dw_prev_familias_update.object.familia[ll_donde]         = this.object.familia[row]
		dw_prev_familias_update.object.serie[ll_donde]           = ""
		dw_prev_familias_update.object.pais[ll_donde]            = ""
		dw_prev_familias_update.object.deposito[ll_donde]        = 0
		
	end if
	
	dw_prev_familias_update.object.prevision[ll_donde]       = this.object.prevision12[row]
	
end if
end event

type dw_prev_familias_update from datawindow within w_mant_venfacprev_estacionalidad
boolean visible = false
integer x = 2071
integer width = 613
integer height = 164
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_mant_prev_familias_update"
boolean livescroll = true
end type

