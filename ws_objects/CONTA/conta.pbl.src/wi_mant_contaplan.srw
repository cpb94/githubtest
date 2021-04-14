$PBExportHeader$wi_mant_contaplan.srw
forward
global type wi_mant_contaplan from wi_mvent_con_empresa
end type
type gb_1 from groupbox within wi_mant_contaplan
end type
type gb_2 from groupbox within wi_mant_contaplan
end type
type pb_calculadora from u_calculadora within wi_mant_contaplan
end type
type uo_ejercicio from u_ejercicio within wi_mant_contaplan
end type
type cb_terceros from commandbutton within wi_mant_contaplan
end type
type gb_3 from groupbox within wi_mant_contaplan
end type
end forward

global type wi_mant_contaplan from wi_mvent_con_empresa
integer width = 2560
integer height = 1308
gb_1 gb_1
gb_2 gb_2
pb_calculadora pb_calculadora
uo_ejercicio uo_ejercicio
cb_terceros cb_terceros
gb_3 gb_3
end type
global wi_mant_contaplan wi_mant_contaplan

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

istr_parametros.s_titulo_ventana  = "Mantenimiento del plan contable"
istr_parametros.s_listado         = "report_contaplan"
istr_parametros.s_filtro          = "ejercicio = " + uo_ejercicio.em_ejercicio.text
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	uo_ejercicio.em_ejercicio.text = istr_parametros.s_argumentos[2]
	sle_valor.text = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text)  or &
		Trim(uo_ejercicio.em_ejercicio.text)<>"" and Not IsNull(uo_ejercicio.em_ejercicio.text)Then
	  dw_1.Retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; String v_directos
 Integer ejercicio,v_niveles,v_nivel

 ejercicio = Integer(uo_ejercicio.em_ejercicio.text)
 v_nivel   = f_controlar_digitos(codigo_empresa,Integer(uo_ejercicio.em_ejercicio.text),sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"cuenta",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"ejercicio",ejercicio)
 dw_1.setitem(dw_1.getrow(),"nivel",v_nivel)
 dw_1.setitem(dw_1.getrow(),"analitica","N")
 SELECT contaparam.niveles INTO :v_niveles   FROM contaparam  
 WHERE ( contaparam.ejercicio = :ejercicio )
 AND  ( contaparam.empresa = :codigo_empresa );

 If  v_nivel = v_niveles Then 
    v_directos="S"
 ELSE
    v_directos="N"
 END IF
 dw_1.setitem(dw_1.getrow(),"directos",v_directos)

end on

on ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
longitud      =  len(trim(uo_ejercicio.em_ejercicio.text))
criterio[3]   =  trim(uo_ejercicio.em_ejercicio.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "contaplan"

dw_1.Retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
uo_ejercicio.enabled = TRUE
end on

on wi_mant_contaplan.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.pb_calculadora=create pb_calculadora
this.uo_ejercicio=create uo_ejercicio
this.cb_terceros=create cb_terceros
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.pb_calculadora
this.Control[iCurrent+4]=this.uo_ejercicio
this.Control[iCurrent+5]=this.cb_terceros
this.Control[iCurrent+6]=this.gb_3
end on

on wi_mant_contaplan.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.pb_calculadora)
destroy(this.uo_ejercicio)
destroy(this.cb_terceros)
destroy(this.gb_3)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
uo_ejercicio.enabled = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contaplan
integer x = 50
integer y = 232
integer width = 1673
integer height = 892
string dataobject = "dw_contaplan"
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_contaplan"
CHOOSE CASE ls_objeto
  
CASE 'pb_tipocta'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipocta")
   OpenWithParm(wi_mant_contatipocta,lstr_param) 
 
END CHOOSE





end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"tipocta")
f_valores_numericos(dw_1,"coste")
end on

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipocta"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contatipocta"
	case "genter_codigo"
		if this.object.genter_tipoter[1] = "B" then
			bus_titulo     = "VENTANA SELECCION DE TERCEROS "
			bus_datawindow = "dw_ayuda_carbancos"
			bus_filtro     = ""
		else
			if this.object.genter_tipoter[1] = "C" then
				bus_titulo     = "VENTANA SELECCION DE TERCEROS "
				bus_datawindow = "dw_ayuda_clientes"			
				bus_filtro     = ""
			else
				if this.object.genter_tipoter[1] = "P" then
					bus_titulo     = "VENTANA SELECCION DE TERCEROS "
					bus_datawindow = "dw_ayuda_proveedores"			
					bus_filtro     = ""					
				else
					SetNull(bus_campo)
				end if
			end if
		end if		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipocta"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contatipocta"
	case "genter_codigo"
		if this.object.genter_tipoter[1] = "B" then
			bus_titulo     = "VENTANA SELECCION DE TERCEROS "
			bus_datawindow = "dw_ayuda_carbancos"
			bus_filtro     = ""
		else
			if this.object.genter_tipoter[1] = "C" then
				bus_titulo     = "VENTANA SELECCION DE TERCEROS "
				bus_datawindow = "dw_ayuda_clientes"			
				bus_filtro     = ""
			else
				if this.object.genter_tipoter[1] = "P" then
					bus_titulo     = "VENTANA SELECCION DE TERCEROS "
					bus_datawindow = "dw_ayuda_proveedores"			
					bus_filtro     = ""					
				else
					SetNull(bus_campo)
				end if
			end if
		end if		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contaplan
integer x = 119
integer y = 132
integer width = 238
string text = "Cuenta:"
alignment alignment = left!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contaplan
integer x = 1938
integer y = 568
integer height = 84
integer textsize = -10
string facename = "Arial"
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contaplan
integer x = 1938
integer y = 696
integer height = 84
integer textsize = -10
string facename = "Arial"
end type

event cb_borrar::clicked;String cta
Dec vejercicio,numero
IF Trim(sle_valor.text) <> ""  and IsNumber(sle_valor.text)Then
  IF Not(f_controlar_niveles_superiores(codigo_empresa,Integer(uo_ejercicio.em_ejercicio.text),sle_valor.text)) THEN
   MessageBox("No Puede borrar esta cuenta","Existen cuentas a niveles superiores",Exclamation!, OK!,1)
   sle_valor.Text = ""
   dw_1.Reset()
   f_activar_campo(sle_valor)
   Return
  END IF
END IF
cta = sle_valor.text
vejercicio = Dec(uo_ejercicio.em_ejercicio.text)
Select Count(*) Into :numero From contaapun
Where  ejercicio = :vejercicio
And    empresa   = :codigo_empresa
And    cuenta    = :cta;
IF IsNull(numero) Then numero = 0
IF numero <> 0 Then
	f_mensaje("Control Borrado Cuenta","No se puede Borrar la cuenta Existen movimientos")
	f_activar_campo(sle_valor)
	Return
END IF
CALL Super::Clicked


end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contaplan
integer x = 370
integer y = 124
integer width = 503
end type

event sle_valor::losefocus;call super::losefocus;integer n_nivel
IF Trim(This.text) <> ""  and IsNumber(This.text)Then


 n_nivel=f_controlar_digitos(codigo_empresa,Integer(uo_ejercicio.em_ejercicio.text),sle_valor.text)
 If n_nivel = 0 Then
   MessageBox("No Puede grabar esta cuenta","El numero de digitos no coincide con digitos por nivel",Exclamation!, OK!,1)
   This.Text = ""
   dw_1.Reset()
   f_activar_campo(sle_valor)
   Return
 END IF


  IF Not(f_controlar_niveles_anteriores(codigo_empresa,Integer(uo_ejercicio.em_ejercicio.text),sle_valor.text)) THEN
   MessageBox("No Puede grabar esta cuenta","No existe cuenta a nivel anterior",Exclamation!, OK!,1)
   This.Text = ""
   dw_1.Reset()
   f_activar_campo(sle_valor)
   Return
 END IF

END IF
end event

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow  = "dw_ayuda_contaplan"
ue_titulo      = "AYUDA SELECCION DE CUENTAS"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contaplan
integer x = 1938
integer y = 824
integer height = 84
integer textsize = -10
string facename = "Arial"
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contaplan
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contaplan
integer y = 84
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contaplan
integer width = 2487
end type

type gb_1 from groupbox within wi_mant_contaplan
integer x = 1920
integer y = 528
integer width = 439
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_2 from groupbox within wi_mant_contaplan
integer x = 1920
integer y = 656
integer width = 439
integer height = 140
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_calculadora from u_calculadora within wi_mant_contaplan
integer x = 887
integer y = 128
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
vtextalign vtextalign = vcenter!
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled = TRUE THEN
  Return
END IF

 Integer registros,var_ejercicio
 var_ejercicio = Integer(uo_ejercicio.em_ejercicio.text)

 Select count(*) Into :registros
 From   contaplan
 Where  contaplan.ejercicio = :var_ejercicio
 and    contaplan.empresa   = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,contaplan.cuenta)+1) Into   :sle_valor.text
  From   contaplan
  Where  contaplan.ejercicio = :var_ejercicio
  and    contaplan.empresa   = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

type uo_ejercicio from u_ejercicio within wi_mant_contaplan
integer x = 1783
integer y = 252
integer width = 631
integer height = 292
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_terceros from commandbutton within wi_mant_contaplan
integer x = 1573
integer y = 80
integer width = 923
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asigna Terceros a Plan Contable"
end type

event clicked;string ls_sel,ls_tipoter,ls_codigo,ls_cuenta
long   ll_indice,ll_total

datastore ds_datos

ls_sel = "  select genter.empresa,genter.tipoter,genter.codigo,genter.razon,genter.cuenta,contaplan.titulo "+&
			"	from   genter,contaplan "+&
			"	where  genter.empresa = '"+codigo_empresa+"' "+&
			"	and    isnull(genter.cuenta,'') <> '' "+&
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    genter.cuenta  = contaplan.cuenta "+&
			"	union "+&
			"	select genter.empresa,genter.tipoter,genter.codigo,genter.razon,venclientes.cuenta_impagados,contaplan.titulo "+&
			"	from   genter,venclientes,contaplan "+&
			"	where  genter.empresa = venclientes.empresa "+&
			"	and    genter.tipoter = 'C' "+&
			"	and    genter.codigo  = venclientes.codigo "+&
			"	and    isnull(venclientes.cuenta_impagados,'') <> '' "+&
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    venclientes.cuenta_impagados = contaplan.cuenta "+&
			"	union "+&
			"	select genter.empresa,genter.tipoter,genter.codigo,genter.razon,venclientes.cuenta_ecc,contaplan.titulo "+&
			"	from   genter,venclientes,contaplan "+&
			"	where  genter.empresa = venclientes.empresa "+&
			"	and    genter.tipoter = 'C' "+&
			"	and    genter.codigo  = venclientes.codigo "+&
			"	and    isnull(venclientes.cuenta_ecc,'') <> '' "+& 
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    venclientes.cuenta_ecc = contaplan.cuenta "+&
			"	union "+&
			"	select genter.empresa,genter.tipoter,genter.codigo,genter.razon,venclientes.cuenta_ecd,contaplan.titulo "+&
			"	from   genter,venclientes,contaplan "+&
			"	where  genter.empresa = venclientes.empresa "+&
			"	and    genter.tipoter = 'C' "+&
			"	and    genter.codigo  = venclientes.codigo "+&
			"	and    isnull(venclientes.cuenta_ecd,'') <> '' "+& 
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    venclientes.cuenta_ecd = contaplan.cuenta "+& 
			"	union "+&
			"	select genter.empresa,genter.tipoter,genter.codigo,genter.razon,venclientes.cuenta_ecgc,contaplan.titulo "+&
			"	from   genter,venclientes,contaplan "+&
			"	where  genter.empresa = venclientes.empresa "+&
			"	and    genter.tipoter = 'C' "+& 
			"	and    genter.codigo  = venclientes.codigo "+& 
			"	and    isnull(venclientes.cuenta_ecgc,'') <> '' "+& 
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    venclientes.cuenta_ecgc = contaplan.cuenta "+& 
			"	union "+&
			"	select genter.empresa,genter.tipoter,genter.codigo,genter.razon,comproveedores.cuenta_irpf,contaplan.titulo "+&
			"	from   genter,comproveedores,contaplan "+&
			"	where  genter.empresa = comproveedores.empresa "+&
			"	and    genter.tipoter = 'P' "+& 
			"	and    genter.codigo  = comproveedores.codigo "+& 
			"	and    isnull(comproveedores.cuenta_irpf,'') <> '' "+& 
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    comproveedores.cuenta_irpf = contaplan.cuenta "+& 
			"	union "+&
			"	select genter.empresa,genter.tipoter,genter.codigo,genter.razon,comproveedores_cuenta.cuenta,contaplan.titulo "+&
			"	from   genter,comproveedores_cuenta,contaplan "+&
			"	where  genter.empresa = comproveedores_cuenta.empresa "+&
			"	and    genter.tipoter = 'P' "+& 
			"	and    genter.codigo  = comproveedores_cuenta.codigo "+& 
			"	and    isnull(comproveedores_cuenta.cuenta,'') <> '' "+& 
			"	and    2019           = contaplan.ejercicio "+&
			"	and    genter.empresa = contaplan.empresa "+&
			"	and    comproveedores_cuenta.cuenta = contaplan.cuenta "+& 
			"	union "+&
			"	select carbancos.empresa,'B' as tipoter,carbancos.banco,carbancos.nombre,carbancos.cuenta,contaplan.titulo "+&
			"	from   carbancos,contaplan "+&
			"	where  carbancos.empresa = '"+codigo_empresa+"' "+&
			"	and    isnull(carbancos.cuenta,'') <> '' "+&
			"	and    2019           = contaplan.ejercicio "+&
			"	and    carbancos.empresa = contaplan.empresa "+&
			"	and    carbancos.cuenta = contaplan.cuenta "+& 
			"	union "+&
			"	select carbancos.empresa,'B' as tipoter,carbancos.banco,carbancos.nombre,carbancos.cta_riesgo,contaplan.titulo "+&
			"	from   carbancos,contaplan "+&
			"	where  carbancos.empresa = '"+codigo_empresa+"' "+&
			"	and    isnull(carbancos.cta_riesgo,'') <> '' "+&
			"	and    2019           = contaplan.ejercicio "+&
			"	and    carbancos.empresa = contaplan.empresa "+&
			"	and    carbancos.cta_riesgo = contaplan.cuenta"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	
	ls_tipoter = ds_datos.object.genter_tipoter[ll_indice]
	ls_codigo  = ds_datos.object.genter_codigo[ll_indice]
	ls_cuenta  = ds_datos.object.genter_cuenta[ll_indice]
	
	update contaplan
	set    contaplan.genter_tipoter = :ls_tipoter,
			 contaplan.genter_codigo  = :ls_codigo 
	where  contaplan.empresa = :codigo_empresa
	and    contaplan.cuenta  = :ls_cuenta;
	
	if sqlca.sqlcode = 0 then
		commit;
	else
		rollback;
	end if
	
next

destroy ds_datos
end event

type gb_3 from groupbox within wi_mant_contaplan
integer x = 1920
integer y = 784
integer width = 439
integer height = 140
integer taborder = 12
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

