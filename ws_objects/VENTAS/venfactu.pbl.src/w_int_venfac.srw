$PBExportHeader$w_int_venfac.srw
forward
global type w_int_venfac from wc_mantenimientos_tab
end type
type dw_pesos_albaranes from u_datawindow within pagina_1
end type
type uo_cliente from u_em_campo_2 within pagina_7
end type
type st_21 from statictext within pagina_7
end type
type em_anyo from u_em_campo within w_int_venfac
end type
type pb_calculadora from u_calculadora within w_int_venfac
end type
type cb_lineas from u_boton within w_int_venfac
end type
type dw_proceso from datawindow within w_int_venfac
end type
type pb_imprimir from upb_imprimir within w_int_venfac
end type
type dw_report from datawindow within w_int_venfac
end type
type gb_1 from groupbox within w_int_venfac
end type
type uo_serie from u_em_campo_2 within w_int_venfac
end type
type st_2 from statictext within w_int_venfac
end type
type dw_listado_vgm from datawindow within w_int_venfac
end type
end forward

global type w_int_venfac from wc_mantenimientos_tab
integer width = 3643
integer height = 2096
em_anyo em_anyo
pb_calculadora pb_calculadora
cb_lineas cb_lineas
dw_proceso dw_proceso
pb_imprimir pb_imprimir
dw_report dw_report
gb_1 gb_1
uo_serie uo_serie
st_2 st_2
dw_listado_vgm dw_listado_vgm
end type
global w_int_venfac w_int_venfac

type variables
str_venfac  venfac
String antecliente,antedivisa
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();str_venlifac linfac
str_venfac   ped 
Integer  reg,reg1 ,v_bien
DataStore  dw
String Sel
Dec{0}  ultima,factura,periodo,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas
Dec{4}  impdto,importe,acumulado,importedto1,importedto2,importedto3,importedto4,importedtopp,importedtoesp,control_precio,control_bruto,control_importedto,control_importe
Dec{2}  var_dto1,var_dto2,var_dto3,var_dto4,var_dtopp,control_descuento
String  var_tipodto1,var_tipodto2,var_tipodto3,var_tipodto4,var_calculo_dto
Dec{4}  var_impdto1,var_impdto2,var_impdto3,var_impdto4
Integer procesos


periodo  =  Integer(em_anyo.text)
factura  =  Dec(sle_valor.text)
Sel = " Select * From venlifac " + &
      " Where  venlifac.empresa = '" + codigo_empresa + "'" + &
		" And    venlifac.anyo    = " + String(periodo,"#####") + &
		" and    venlifac.factura = " + String(factura,"########")
//dw   = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, dw)
reg1 = dw.RowCount()

linfac.empresa  = codigo_empresa
linfac.anyo     = periodo
linfac.factura  = factura
v_bien = 0	

For reg = 1 To reg1 
 linfac.linea_factura = dw.GetItemNumber(reg,"linea_factura")
 IF Not f_actualizar_linea_venfac(linfac.empresa,linfac.anyo,linfac.factura,linfac.linea_factura) Then 
	v_bien = 1
	f_mensaje("Error","al actualizar linea de factura"+sqlca.sqlerrtext)
 END IF
NEXT

IF Not f_actualizar_venfactura_peso(codigo_empresa,linfac.anyo,linfac.factura,"N") Then 
	v_bien = 1
	f_mensaje("Error","al actualizar linea de factura"+sqlca.sqlerrtext)
END IF

dw.Reset()
IF v_bien = 0 Then
	   COMMIT;
  ELSE
    	ROLLBACK;
   	f_mensaje("Error en base de datos","La operacion no se actualiza")
END IF

destroy dw
end subroutine

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = TRUE
pag7 = TRUE
pag5 = TRUE
pag6 = TRUE



prin_pag1  =  TRUE
pag_act7   =  FALSE


end event

on w_int_venfac.create
int iCurrent
call super::create
this.em_anyo=create em_anyo
this.pb_calculadora=create pb_calculadora
this.cb_lineas=create cb_lineas
this.dw_proceso=create dw_proceso
this.pb_imprimir=create pb_imprimir
this.dw_report=create dw_report
this.gb_1=create gb_1
this.uo_serie=create uo_serie
this.st_2=create st_2
this.dw_listado_vgm=create dw_listado_vgm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_anyo
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.cb_lineas
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.uo_serie
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_listado_vgm
end on

on w_int_venfac.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_anyo)
destroy(this.pb_calculadora)
destroy(this.cb_lineas)
destroy(this.dw_proceso)
destroy(this.pb_imprimir)
destroy(this.dw_report)
destroy(this.gb_1)
destroy(this.uo_serie)
destroy(this.st_2)
destroy(this.dw_listado_vgm)
end on

event ue_recuperar;//-------------------------------------------------
// Valores Para Funcion de bloqueo-----------------
//-------------------------------------------------

titulo        =  This.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(string(dec(em_anyo.text))))
criterio[2]   =  Trim(string(dec(em_anyo.text)))+space(20-longitud)
longitud      =  len(trim(string(dec(sle_valor.text))))
criterio[3]   =  trim(string(dec(sle_valor.text)))+space(20-longitud)
seleccion[1]  =  criterio[1]+criterio[2]+criterio[3]
tabla[1]      = "venfac"

IF dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text)) = 0 Then
	dw_pag1.SetTabOrder("cliente",1)
	dw_pag1.SetTabOrder("ffactura",2)
ELSE
	dw_pag1.SetTabOrder("cliente",0)
	dw_pag1.SetTabOrder("ffactura",1)
END IF
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag5.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag6.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
apartados.pagina_1.dw_pesos_albaranes.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;
IF Trim(f_valor_columna(dw_pag1,1,"empresa")) = "" Then
 dw_pag1.SetItem(1,"factura",Dec(sle_valor.text))
 dw_pag1.SetItem(1,"actualizada","N")
 dw_pag1.SetItem(1,"falbaran",DateTime(Today()))
 dw_pag1.SetItem(1,"ffactura",DateTime(Today()))
 dw_pag1.SetItem(1,"usuario_pedido",nombre_usuario)
 dw_pag1.SetItem(1,"usuario",nombre_usuario)
 dw_pag1.SetItem(1,"cartera","S")
 dw_pag1.SetItem(1,"precartera","N")
 dw_pag1.SetItem(1,"marcada","N")
END IF

dw_pag1.SetItem(1,"empresa",codigo_empresa)
dw_pag1.SetItem(1,"anyo",Dec(em_anyo.text))
dw_pag2.SetItem(1,"empresa",codigo_empresa)







end event

event open;call super::open;titulo= "Introducción de Facturas"
This.title = titulo
dw_proceso.SetTransObject(SQLCA)
dw_pag1.SetTransObject(SQLCA)
dw_pag2.SetTransObject(SQLCA)
dw_pag7.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))

dw_listado_vgm.SetTransObject(SQLCA)

apartados.pagina_1.dw_pesos_albaranes.settransobject(sqlca)

f_mascara_columna(apartados.pagina_1.dw_pesos_albaranes,"peso_neto_albaran","###,###")
f_mascara_columna(apartados.pagina_1.dw_pesos_albaranes,"peso_bruto_albaran","###,###")
f_mascara_columna(apartados.pagina_1.dw_pesos_albaranes,"neto_total","###,###")
f_mascara_columna(apartados.pagina_1.dw_pesos_albaranes,"bruto_total","###,###")
f_mascara_columna(apartados.pagina_1.dw_pesos_albaranes,"tara_contenedor","###,###")

f_mascara_columna(dw_pag1,"peso","###,###")
f_mascara_columna(dw_pag1,"peso_neto","###,###")
f_mascara_columna(dw_pag2,"dtoesp1","###.00")
f_mascara_columna(dw_pag2,"dtoesp2","###.00")
f_mascara_columna(dw_pag2,"dtoesp3","###.00")
f_mascara_columna(dw_pag2,"dtoesp4","###.00")
f_mascara_columna(dw_pag2,"dtopp","###.00")

f_mascara_columna(dw_pag2,"comision11","##0.00")
f_mascara_columna(dw_pag2,"comision12","##0.00")
f_mascara_columna(dw_pag2,"comision21","##0.00")
f_mascara_columna(dw_pag2,"comision22","##0.00")
f_mascara_columna(dw_pag2,"comision31","##0.00")
f_mascara_columna(dw_pag2,"comision32","##0.00")

 // Si recibo el codigo lo visualizo
   
	IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]
      sle_valor.text=istr_parametros.s_argumentos[3]
      IF len(sle_valor.text) <> 0  and len(em_anyo.text)<> 0 Then
       This.TriggerEvent("ue_recuperar")
		 f_activar_campo(sle_valor)
      END IF
   END IF
	
	
end event

event ue_pase_valores;call super::ue_pase_valores;dw_pag1.SetItem(1,"observaciones",dw_pag2.GetItemString(1,"observaciones"))
dw_pag1.SetItem(1,"observaciones_alb",dw_pag2.GetItemString(1,"observaciones_alb"))

dw_pag1.SetItem(1,"agente1",dw_pag2.GetItemString(1,"agente1"))
dw_pag1.SetItem(1,"agente2",dw_pag2.GetItemString(1,"agente2"))
dw_pag1.SetItem(1,"agente3",dw_pag2.GetItemString(1,"agente3"))
dw_pag1.SetItem(1,"comision11",dw_pag2.GetItemNumber(1,"comision11"))
dw_pag1.SetItem(1,"comision21",dw_pag2.GetItemNumber(1,"comision21"))
dw_pag1.SetItem(1,"comision31",dw_pag2.GetItemNumber(1,"comision31"))
dw_pag1.SetItem(1,"comision11",dw_pag2.GetItemNumber(1,"comision11"))
dw_pag1.SetItem(1,"comision22",dw_pag2.GetItemNumber(1,"comision22"))
dw_pag1.SetItem(1,"comision32",dw_pag2.GetItemNumber(1,"comision32"))
dw_pag1.SetItem(1,"dtopp",dw_pag2.GetItemNumber(1,"dtopp"))
dw_pag1.SetItem(1,"dtoesp",dw_pag2.GetItemNumber(1,"dtoesp"))
dw_pag1.SetItem(1,"dtoesp1",dw_pag2.GetItemNumber(1,"dtoesp1"))
dw_pag1.SetItem(1,"dtoesp2",dw_pag2.GetItemNumber(1,"dtoesp2"))
dw_pag1.SetItem(1,"dtoesp3",dw_pag2.GetItemNumber(1,"dtoesp3"))
dw_pag1.SetItem(1,"dtoesp4",dw_pag2.GetItemNumber(1,"dtoesp4"))
dw_pag1.SetItem(1,"tipodto1",dw_pag2.GetItemString(1,"tipodto1"))
dw_pag1.SetItem(1,"tipodto2",dw_pag2.GetItemString(1,"tipodto2"))
dw_pag1.SetItem(1,"tipodto3",dw_pag2.GetItemString(1,"tipodto3"))
dw_pag1.SetItem(1,"tipodto4",dw_pag2.GetItemString(1,"tipodto4"))
dw_pag1.SetItem(1,"calculo_dto",dw_pag2.GetItemString(1,"calculo_dto"))
dw_pag1.SetItem(1,"calculo_dtoesp",dw_pag2.GetItemString(1,"calculo_dtoesp"))
dw_pag1.SetItem(1,"explicaciondto1",dw_pag2.GetItemString(1,"explicaciondto1"))
dw_pag1.SetItem(1,"explicaciondto2",dw_pag2.GetItemString(1,"explicaciondto2"))
dw_pag1.SetItem(1,"explicaciondto3",dw_pag2.GetItemString(1,"explicaciondto3"))
dw_pag1.SetItem(1,"explicaciondto4",dw_pag2.GetItemString(1,"explicaciondto4"))

dw_pag1.SetItem(1,"valor_frontera",dw_pag2.GetItemNumber(1,"valor_frontera"))
dw_pag1.SetItem(1,"contenedor",dw_pag2.GetItemString(1,"contenedor"))
dw_pag1.SetItem(1,"precinto",dw_pag2.GetItemString(1,"precinto"))

dw_pag1.SetItem(1,"envio",dw_pag2.GetItemString(1,"envio"))
dw_pag1.SetItem(1,"correspondencia",dw_pag2.GetItemString(1,"correspondencia"))
dw_pag1.SetItem(1,"domiciliacion",dw_pag2.GetItemString(1,"domiciliacion"))
dw_pag1.SetItem(1,"transportista",dw_pag2.GetItemString(1,"transportista"))

dw_pag1.SetItem(1,"periodo_fac",dw_pag2.GetItemString(1,"periodo_fac"))
dw_pag1.SetItem(1,"agrupa",dw_pag2.GetItemString(1,"agrupa"))

dw_pag1.SetItem(1,"textcomercial1",dw_pag3.GetItemString(1,"textcomercial1"))
dw_pag1.SetItem(1,"textcomercial2",dw_pag3.GetItemString(1,"textcomercial2"))
dw_pag1.SetItem(1,"destino1",dw_pag3.GetItemString(1,"destino1"))
dw_pag1.SetItem(1,"destino2",dw_pag5.GetItemString(1,"destino2"))
dw_pag1.SetItem(1,"destino3",dw_pag6.GetItemString(1,"destino3"))

dw_pag1.SetItem(1,"textaduanaesp1",dw_pag5.GetItemString(1,"textaduanaesp1"))
dw_pag1.SetItem(1,"textaduanaesp2",dw_pag5.GetItemString(1,"textaduanaesp2"))

dw_pag1.SetItem(1,"textaduanaext1",dw_pag6.GetItemString(1,"textaduanaext1"))
dw_pag1.SetItem(1,"textaduanaext2",dw_pag6.GetItemString(1,"textaduanaext2"))
end event

event ue_activa_claves;call super::ue_activa_claves;apartados.pagina_7.visible = TRUE
cb_lineas.enabled      = TRUE
pb_calculadora.visible = TRUE
pb_imprimir.visible	  = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;apartados.pagina_7.visible = FALSE
cb_lineas.enabled = FALSE
pb_calculadora.visible = FALSE
pb_imprimir.visible = FALSE
end event

event ue_f6;call super::ue_f6;cb_lineas.TriggerEvent(Clicked!)
end event

event ue_borra_fila;call super::ue_borra_fila;//Integer anyo
//Dec{0}  factura
//anyo = Dec(em_anyo.text)
//factura = Dec(sle_valor.text)
//Delete from  venlifac
//Where  empresa  = :codigo_empresa
//And    anyo     = :anyo
//And    factura = :factura;
end event

event activate;call super::activate;w_int_venfac = ventanas_activas[id_ventana_activa].ventana
end event

event ue_actualiza_dw;//Control cambio de pesos

dec ld_peso_neto_lineas,ld_peso_bruto_lineas
dec ld_peso_neto_cabecera,ld_peso_bruto_cabecera
dec ld_factor_correccion_peso_neto,ld_factor_correccion_peso_bruto,ld_diferencia_peso_bruto,ld_diferencia_peso_neto
dec ld_peso_bruto_maximo_linea
int li_anyo,li_anyo_albaran
long ll_factura,ll_linea_a_modificar_peso,ll_indice,ll_total,ll_albaran
boolean lb_correcto = true

string ls_contenedor,ls_precinto,ls_matricula,ls_remolque,ls_booking,ls_metodo_verificacion_masa_bruta
long   ll_tara_contenedor
string ls_contenedor_actual,ls_precinto_actual,ls_matricula_actual,ls_remolque_actual,ls_booking_actual,ls_metodo_verificacion_masa_bruta_actual
long   ll_tara_contenedor_actual

str_vencimientos lstr_vencimientos
str_carefectos   lstr_carefectos
str_venfac       lstr_venfac
int li_recibo

li_anyo = dec(em_anyo.text)
ll_factura = dec(sle_valor.text)

lstr_venfac.empresa = codigo_empresa
lstr_venfac.anyo    = li_anyo
lstr_venfac.factura = ll_factura

apartados.pagina_1.dw_pesos_albaranes.accepttext()

ll_total = apartados.pagina_1.dw_pesos_albaranes.rowcount()

for ll_indice = 1 to ll_total
	
	li_anyo_albaran = apartados.pagina_1.dw_pesos_albaranes.object.anyo_albaran[ll_indice]
	ll_albaran      = apartados.pagina_1.dw_pesos_albaranes.object.albaran[ll_indice]
	
	
	//Chequeamos primero los datos de matriculas,contenedor,.....
	ls_contenedor                     = apartados.pagina_1.dw_pesos_albaranes.object.contenedor[ll_indice]
	ls_precinto                       = apartados.pagina_1.dw_pesos_albaranes.object.precinto[ll_indice]
	ls_matricula                      = apartados.pagina_1.dw_pesos_albaranes.object.matricula[ll_indice]
	ls_remolque                       = apartados.pagina_1.dw_pesos_albaranes.object.remolque[ll_indice]
	ls_booking                        = apartados.pagina_1.dw_pesos_albaranes.object.booking[ll_indice]
	ll_tara_contenedor                = apartados.pagina_1.dw_pesos_albaranes.object.tara_contenedor[ll_indice]
	ls_metodo_verificacion_masa_bruta = apartados.pagina_1.dw_pesos_albaranes.object.metodo_verificacion_masa_bruta[ll_indice]
	
	select max(isnull(contenedor,'')),
			 max(isnull(precinto,'')),
			 max(isnull(matricula,'')),
			 max(isnull(remolque,'')),
			 max(isnull(booking,'')),
			 sum(isnull(tara_contenedor,0)),
			 max(isnull(metodo_verificacion_masa_bruta,''))
	into   :ls_contenedor_actual,
			 :ls_precinto_actual,
			 :ls_matricula_actual,
			 :ls_remolque_actual,
			 :ls_booking_actual,
			 :ll_tara_contenedor_actual,
			 :ls_metodo_verificacion_masa_bruta_actual
	from   venlifac
	where  empresa      = :codigo_empresa
	and    anyo         = :li_anyo
	and    factura      = :ll_factura
	and    anyo_albaran = :li_anyo_albaran
	and    albaran      = :ll_albaran;	
	
	if ls_contenedor                     <> ls_contenedor_actual or &
		ls_precinto                       <> ls_precinto_actual or &
		ls_matricula                      <> ls_matricula_actual or &
		ls_remolque                       <> ls_remolque_actual or &
		ls_booking                        <> ls_booking_actual or &
		ll_tara_contenedor                <> ll_tara_contenedor_actual or &
		ls_metodo_verificacion_masa_bruta <> ls_metodo_verificacion_masa_bruta_actual then
		
		update venlifac
		set    contenedor                     = :ls_contenedor,
				 precinto                       = :ls_precinto,
				 matricula                      = :ls_matricula,
				 remolque                       = :ls_remolque,
				 booking                        = :ls_booking,
				 tara_contenedor                = :ll_tara_contenedor,
				 metodo_verificacion_masa_bruta = :ls_metodo_verificacion_masa_bruta
		Where  empresa       = :codigo_empresa
		And    anyo          = :li_anyo
		And    factura       = :ll_factura
		and    anyo_albaran  = :li_anyo_albaran
		and    albaran       = :ll_albaran;
		
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar datos alb "+string(ll_albaran,"#####0"),sqlca.sqlerrtext)
			lb_correcto = false
		end if				
		
	end if
	
	select sum(isnull(peso,0)),
			 sum(isnull(peso_neto,0))
	into   :ld_peso_bruto_lineas,
			 :ld_peso_neto_lineas
	from   venlifac
	where  empresa      = :codigo_empresa
	and    anyo         = :li_anyo
	and    factura      = :ll_factura
	and    anyo_albaran = :li_anyo_albaran
	and    albaran      = :ll_albaran;
	
	ld_peso_neto_cabecera  = apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_indice]//apartados.pagina_1.dw_pagina1.object.peso_neto[1]
	ld_peso_bruto_cabecera = apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_indice]//apartados.pagina_1.dw_pagina1.object.peso[1] 
	
	if ld_peso_bruto_cabecera <> ld_peso_bruto_lineas then
		if ld_peso_bruto_lineas <> 0 then
			ld_factor_correccion_peso_bruto  = ld_peso_bruto_cabecera / ld_peso_bruto_lineas
		else
			ld_factor_correccion_peso_bruto  = 0
		end if	
				
		update venlifac
		set    peso = round(isnull(peso,0) * :ld_factor_correccion_peso_bruto,2)
		Where  empresa = :codigo_empresa
		And    anyo    = :li_anyo
		And    factura = :ll_factura
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;	
		
		select sum(isnull(peso,0))
		into   :ld_peso_bruto_lineas
		from   venlifac
		where  empresa = :codigo_empresa
		and    anyo    = :li_anyo
		and    factura = :ll_factura
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;	
	else	
		update venlifac
		set    peso = peso
		Where  empresa = :codigo_empresa
		And    anyo    = :li_anyo
		And    factura = :ll_factura
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;			
		
	end if	
	
	select sum(isnull(peso,0))
	into   :ld_peso_bruto_lineas
	from   venlifac
	where  empresa      = :codigo_empresa
	and    anyo         = :li_anyo
	and    factura      = :ll_factura
	and    anyo_albaran = :li_anyo_albaran
	and    albaran      = :ll_albaran;	
	
	if ld_peso_neto_cabecera <> ld_peso_bruto_lineas then //ld_peso_neto_lineas 
		if ld_peso_neto_lineas <> 0 then
			//ld_factor_correccion_peso_neto  = ld_peso_neto_cabecera / ld_peso_neto_lineas
			ld_factor_correccion_peso_neto  = ld_peso_neto_cabecera / ld_peso_bruto_lineas
		else
			ld_factor_correccion_peso_neto  = 0
		end if
		
//		update venlifac
//		set    peso_neto = round(isnull(peso_neto_calculado,0) * :ld_factor_correccion_peso_neto,2)
//		Where  empresa = :codigo_empresa
//		And    anyo    = :li_anyo
//		And    factura = :ll_factura	
//		and    anyo_albaran = :li_anyo_albaran
//		and    albaran      = :ll_albaran;			
		
		update venlifac
		set    peso_neto = round(isnull(peso,0) * :ld_factor_correccion_peso_neto,2)
		Where  empresa = :codigo_empresa
		And    anyo    = :li_anyo
		And    factura = :ll_factura	
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;	
		
		select sum(isnull(peso_neto,0))
		into   :ld_peso_neto_lineas
		from   venlifac
		where  empresa = :codigo_empresa
		and    anyo    = :li_anyo
		and    factura = :ll_factura
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;	
	else
		update venlifac
		set    peso_neto = peso_neto
		Where  empresa = :codigo_empresa
		And    anyo    = :li_anyo
		And    factura = :ll_factura	
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;			
	end if
		
	ld_diferencia_peso_bruto = ld_peso_bruto_cabecera - ld_peso_bruto_lineas
	ld_diferencia_peso_neto  = ld_peso_neto_cabecera - ld_peso_neto_lineas
	
	//Buscaremos la linea con mas peso y la regularizaremos para que el peso total nos cuadre con la cabecera
	
	ld_peso_bruto_maximo_linea = 0
	
	select max(peso)
	into   :ld_peso_bruto_maximo_linea
	from   venlifac
	Where  empresa = :codigo_empresa
	And    anyo    = :li_anyo
	And    factura = :ll_factura
	and    anyo_albaran = :li_anyo_albaran
	and    albaran      = :ll_albaran;			
	
	if isnull(ld_peso_bruto_maximo_linea) then ld_peso_bruto_maximo_linea = 0
	
	ll_linea_a_modificar_peso =  0
	
	select min(linea_factura)
	into   :ll_linea_a_modificar_peso
	from   venlifac
	Where  empresa = :codigo_empresa
	And    anyo    = :li_anyo
	And    factura = :ll_factura
	and    peso    = :ld_peso_bruto_maximo_linea
	and    anyo_albaran = :li_anyo_albaran
	and    albaran      = :ll_albaran;			
				
	if isnull(ll_linea_a_modificar_peso) then ll_linea_a_modificar_peso = 0
	
	if ll_linea_a_modificar_peso = 0 then
		select min(linea_factura)
		into   :ll_linea_a_modificar_peso
		from   venlifac
		Where  empresa = :codigo_empresa
		And    anyo    = :li_anyo
		And    factura = :ll_factura
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;		
		
		if isnull(ll_linea_a_modificar_peso) then ll_linea_a_modificar_peso = 0
	end if
	
	if ll_linea_a_modificar_peso > 0 then			
		update venlifac
		set    peso      = peso + :ld_diferencia_peso_bruto,
				 peso_neto = peso_neto + :ld_diferencia_peso_neto
		Where  empresa = :codigo_empresa
		And    anyo    = :li_anyo
		And    factura = :ll_factura
		and    linea_factura = :ll_linea_a_modificar_peso
		and    anyo_albaran = :li_anyo_albaran
		and    albaran      = :ll_albaran;
		
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error al modificar peso alb "+string(ll_albaran,"#####0"),sqlca.sqlerrtext)
			lb_correcto = false
		end if				
	end if
	
next

datetime ldt_venfac_ffactura_original,ldt_venfac_fecha_lb_original

select venfac.ffactura,
		 isnull(venfac.fecha_lb,venfac.ffactura)
into   :ldt_venfac_ffactura_original,
		 :ldt_venfac_fecha_lb_original
from   venfac
where  venfac.empresa = :lstr_venfac.empresa
and    venfac.anyo    = :lstr_venfac.anyo
and    venfac.factura = :lstr_venfac.factura;

if lb_correcto then
	call super::ue_actualiza_dw
end if

//Actualizamos los vencimientos si es necesario

int li_existe_efecto 

select venfac.codpago,
 		 venfac.ffactura,
		 venfac.fecha_lb
into   :lstr_venfac.codpago,
		 :lstr_venfac.ffactura,
		 :lstr_venfac.fecha_lb
from   venfac
where  venfac.empresa = :lstr_venfac.empresa
and    venfac.anyo    = :lstr_venfac.anyo
and    venfac.factura = :lstr_venfac.factura;

if ldt_venfac_ffactura_original <> lstr_venfac.ffactura or ldt_venfac_fecha_lb_original <> lstr_venfac.fecha_lb then
	lstr_carefectos.empresa = lstr_venfac.empresa
	lstr_carefectos.anyofra = lstr_venfac.anyo
	lstr_carefectos.factura = string(lstr_venfac.factura,'######0')
	
	lstr_vencimientos = f_vencimientos_factura(codigo_empresa,lstr_venfac.anyo,lstr_venfac.factura)
	
	For li_recibo = 1 To lstr_vencimientos.efectos 
		
		lstr_carefectos.fvto     = DateTime(lstr_vencimientos.vencimiento[li_recibo])
		
		lstr_carefectos.fvto_original = lstr_carefectos.fvto
		lstr_carefectos.recibo   = li_recibo
		
		choose case li_recibo
			case 1
				lstr_carefectos.fpago = f_codpago1_carforpag(codigo_empresa,lstr_venfac.codpago)
			case 2
				lstr_carefectos.fpago = f_codpago2_carforpag(codigo_empresa,lstr_venfac.codpago)			
			case 3
				lstr_carefectos.fpago = f_codpago3_carforpag(codigo_empresa,lstr_venfac.codpago)						
			case 4
				lstr_carefectos.fpago = f_codpago4_carforpag(codigo_empresa,lstr_venfac.codpago)						
			case 5
				lstr_carefectos.fpago = f_codpago5_carforpag(codigo_empresa,lstr_venfac.codpago)						
			case 6
				lstr_carefectos.fpago = f_codpago6_carforpag(codigo_empresa,lstr_venfac.codpago)						
			case 7
				lstr_carefectos.fpago = f_codpago7_carforpag(codigo_empresa,lstr_venfac.codpago)						
			case 8
				lstr_carefectos.fpago = f_codpago8_carforpag(codigo_empresa,lstr_venfac.codpago)						
			case 9
				lstr_carefectos.fpago = f_codpago9_carforpag(codigo_empresa,lstr_venfac.codpago)						
		end choose
		
		lstr_carefectos.tipodoc  = f_tipodoc_carforpag(lstr_venfac.empresa,lstr_carefectos.fpago)
		lstr_carefectos.recibir_dmto = f_cartipodoc_recibir_dcto(lstr_venfac.empresa,lstr_carefectos.tipodoc)
		
		if lstr_carefectos.tipodoc = "2" or lstr_carefectos.tipodoc = "5" or lstr_carefectos.tipodoc = "6" or lstr_carefectos.tipodoc = "7" or lstr_carefectos.tipodoc = "11" or lstr_carefectos.tipodoc = "12" then
			lstr_carefectos.situacion = "10"
		else
			IF lstr_venfac.cartera = "N" Then
				lstr_carefectos.situacion = "4"
			ELSE
				lstr_carefectos.situacion = f_tipodoc_situacion_pase_cartera(codigo_empresa,lstr_carefectos.tipodoc)
			END IF		
		end if
			
		li_existe_efecto = 0	
			
		select isnull(count(*),0)
		into   :li_existe_efecto
		from   carefectos
		where  carefectos.empresa   = :lstr_carefectos.empresa
		and    carefectos.anyofra      = :lstr_carefectos.anyofra
		and    carefectos.factura   = :lstr_carefectos.factura
		and    carefectos.situacion = :lstr_carefectos.situacion
		and    carefectos.recibo    = :lstr_carefectos.recibo
		and    carefectos.fvto     <> :lstr_carefectos.fvto;
		
		if li_existe_efecto > 0 then
			update carefectos
			set    carefectos.fvto = :lstr_carefectos.fvto
			where  carefectos.empresa   = :lstr_carefectos.empresa
			and    carefectos.anyofra      = :lstr_carefectos.anyofra
			and    carefectos.factura   = :lstr_carefectos.factura
			and    carefectos.situacion = :lstr_carefectos.situacion
			and    carefectos.recibo    = :lstr_carefectos.recibo
			and    carefectos.fvto     <> :lstr_carefectos.fvto;			
			
			if sqlca.sqlcode <> 0 then
				lb_correcto = false
			end if
		end if
	Next
	
	if lb_correcto then
		commit;
	else
		rollback;
		messagebox("¡Atención!","Se ha producido un error al modificar los vencimientos.")
	end if
end if
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_int_venfac
integer x = 2414
integer y = 172
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_int_venfac
integer x = 2107
integer y = 172
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

event cb_borrar::clicked;//Nada
String contabilizada 
Long fila, albaran
Dec factura, anyo

albaran = 0
contabilizada = ""
anyo = 0
factura = 0

if MessageBox("Atención", "¿Está seguro de que desea eliminar la factura actual?", Question!, YesNo!, 2) = 2 then
	return
end if

fila = apartados.pagina_1.dw_pagina1.GetRow()
if fila > 0 then
	contabilizada = apartados.pagina_1.dw_pagina1.GetItemString(fila,'actualizada')	
	albaran = apartados.pagina_1.dw_pagina1.GetItemNumber(fila,'albaran')	
	factura = apartados.pagina_1.dw_pagina1.GetItemNumber(fila,'factura')	
	anyo = apartados.pagina_1.dw_pagina1.GetItemNumber(fila,'anyo')	
	if contabilizada = "S" then
		MessageBox("Error", "No se puede borrar facturas contabilizadas")
		return
	end if
	if not isnull(albaran) and albaran <> 0 then
		MessageBox("Error", "No se puede borrar facturas que proceden de un albarán. Utilice para ello 'Anulación de Facturas'.")
		return
	end if
	if not isnull(factura) and factura <> 0 and not isnull(anyo) and anyo <> 0 then
		DELETE FROM venfac WHERE empresa = :codigo_empresa AND anyo = :anyo AND factura = :factura;
		DELETE FROM venlifac WHERE empresa = :codigo_empresa AND anyo = :anyo AND factura = :factura;
		Parent.triggerevent("ue_recuperar")
	end if
end if
//if (Trim(actualizada)="S"
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_int_venfac
integer x = 1801
integer y = 172
integer width = 306
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;String var_codpago,var_bancocobro,control_banco,campo,actualizada,var_asegurado
datawindow dato
Integer numero,var_mes
dec var_cambio
real var_cambio_euros
datetime var_fecha

if uo_serie.em_codigo.text <> '' and not isnull(uo_serie.em_codigo.text) then
	IF  cb_insertar.enabled = TRUE Then
		var_codpago    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'codpago')	
		var_bancocobro = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'banco_de_cobro')	
		var_cambio     = apartados.pagina_1.dw_pagina1.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'cambio')	
		var_cambio_euros = apartados.pagina_1.dw_pagina1.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'cambio_euros')	
		var_fecha      = apartados.pagina_1.dw_pagina1.GetItemdatetime(apartados.pagina_1.dw_pagina1.GetRow(),'ffactura')	 	
		var_asegurado = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'asegurado')	 	
		
		var_mes = month(date(var_fecha))
		dw_pag1.SetItem(1,"mes",var_mes)
		
		if Trim(var_codpago)<>"" then
			control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
			if control_banco = "S" and Trim(var_bancocobro)="" then
			  campo="banco_de_cobro"
			  dato = apartados.pagina_1.dw_pagina1
			  numero = 1
			End if
		End If
		
		if Trim(var_asegurado) = ""  then
		  campo="asegurado"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
		End If
		
		IF Trim(campo)<>"" THEN
		  MessageBox(" "+campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
		  apartados.SelectTab(numero)
		  dato.setfocus()
		  dato.SetColumn(campo)
		  Return
		END IF
		
		IF Dec(f_valor_columna(dw_pag2,1,"dtoesp1")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto1","")
		IF Dec(f_valor_columna(dw_pag2,1,"dtoesp2")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto2","")
		IF Dec(f_valor_columna(dw_pag2,1,"dtoesp3")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto3","")
		IF Dec(f_valor_columna(dw_pag2,1,"dtoesp4")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto4","")
	
		dw_pag1.SetItem(1,"iva",f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,dw_pag1.GetItemString(1,"tipoiva")))
		if var_cambio=0 or isnull(var_cambio) then dw_pag1.SetItem(1,"cambio",f_cambio_moneda(dw_pag1.GetItemString(1,"divisa")))
		if var_cambio_euros =0 or isnull(var_cambio_euros) then dw_pag1.SetItem(1,"cambio_euros",f_cambio_euros(dw_pag1.GetItemString(1,"divisa")))
		
		call super::clicked
		commit;
		f_control()
	ELSE
		call super::clicked
	END IF 
else
	messagebox ("Atención", "La serie es obligatoria")
end if
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_int_venfac
integer taborder = 60
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_int_venfac
integer height = 92
end type

event st_empresa::clicked;call super::clicked;str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_lis_venproformas,lstr_param)
 f_activar_campo(sle_valor)
end event

type sle_valor from wc_mantenimientos_tab`sle_valor within w_int_venfac
integer x = 841
integer y = 164
integer width = 256
integer taborder = 40
end type

event sle_valor::getfocus;call super::getfocus;dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

end event

type st_1 from wc_mantenimientos_tab`st_1 within w_int_venfac
integer x = 50
integer y = 168
integer width = 238
integer height = 84
string text = "Factura:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within w_int_venfac
integer x = 5
integer y = 260
integer width = 3630
integer height = 1676
boolean multiline = true
end type

event apartados::clicked;call super::clicked;IF index =7 Then
	f_activar_campo(apartados.pagina_7.uo_cliente.em_campo)
END IF
end event

on apartados.create
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
call super::destroy
end on

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 3593
integer height = 1548
string text = "Datos Facturación."
dw_pesos_albaranes dw_pesos_albaranes
end type

on pagina_1.create
this.dw_pesos_albaranes=create dw_pesos_albaranes
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pesos_albaranes
end on

on pagina_1.destroy
call super::destroy
destroy(this.dw_pesos_albaranes)
end on

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 5
integer y = 4
integer width = 2779
integer height = 1540
string dataobject = "dw_int_venfac5"
boolean border = true
end type

event dw_pagina1::clicked;call super::clicked;IF GetRow() = 0  Then return
str_parametros lstr_param
CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_cliente"
 
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
 OpenWithParm(wi_mant_clientes2,lstr_param)  

CASE "pb_envio"
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"envio")
   OpenWithParm(wi_mant_venenvio,lstr_param)  
CASE "pb_correspondencia"
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"correspondencia")
   OpenWithParm(wi_mant_vencorrespondencia,lstr_param)  
CASE "pb_codentrega" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_entrega")
	OpenWithParm(wi_mant_vencondentrega,lstr_param)  
CASE "pb_codpago" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"codpago")
	OpenWithParm(wi_mant_carforpag,lstr_param)  

CASE "pb_idioma" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"idioma")
	OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE "pb_tipo_iva" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"tipoiva")
	OpenWithParm(wi_mant_contaiva,lstr_param)  
 
END CHOOSE


end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;String var_texto1,var_texto2,var_condicion,var_moneda,var_tarifa,var_idioma
string control_banco, var_codpago
dec var_cambio
real var_cambio_euros

var_texto1  = f_valor_columna(This,This.GetRow(),'textopie1')
var_texto2  = f_valor_columna(This,This.GetRow(),'textopie2')
var_tarifa  = f_valor_columna(This,This.GetRow(),'tarifa')
var_idioma  = f_valor_columna(This,This.GetRow(),'idioma')
var_codpago = f_valor_columna(This,This.GetRow(),'codpago')


IF Trim(var_texto1) = "" or IsNull(var_texto1)   then
	var_texto1 = f_nombre_vencondentrega(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'))
   f_asignar_columna(This,This.getrow(),"textopie1",var_texto1)
END IF

IF Trim(var_texto2) = "" or IsNull(var_texto2) then
	var_texto2 = f_nombre_vencondentrega_idioma(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'),var_idioma)
   f_asignar_columna(This,This.getrow(),"textopie2",var_texto2)
END IF

var_condicion = f_condicion_vencondentrega(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'))
f_asignar_columna(This,This.getrow(),"condicion",var_condicion)
This.SetTabOrder("divisa",90)
IF Trim(var_tarifa) <> "" and Not IsNull(var_tarifa) Then
// Asignamos la moneda del cliente. Santiago. 16/01/01	
//	var_moneda = f_moneda_ventarifas(codigo_empresa,var_tarifa)
	var_moneda = f_moneda_cliente(codigo_empresa,f_valor_columna(This,This.GetRow(),'cliente'))
// Asignamos la moneda del cliente. Santiago. 16/01/01
	var_cambio = f_cambio_moneda(var_moneda)
	var_cambio_euros = f_cambio_euros(var_moneda)
	if var_moneda <> antedivisa then
		f_asignar_columna(This,This.GetRow(),"divisa",var_moneda)
		f_asignar_columna(This,This.GetRow(),"cambio",String(var_cambio))
		f_asignar_columna(This,This.GetRow(),"cambio_euros",String(var_cambio_euros))
		antedivisa = var_moneda
	end if
	This.SetTabOrder("divisa",0)
END IF

control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))

This.SetTabOrder("banco_de_cobro",130)
if control_banco = "N" then
	This.SetTabOrder("banco_de_cobro",0)
	f_asignar_columna(dw_pag1,1,"banco_de_cobro","")
END IF


end event

event dw_pagina1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"

  CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
      valor_empresa = FALSE		  
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISAS"
		   valor_empresa = FALSE
  CASE "tarifa"
      bus_datawindow = "dw_ayuda_ventarifas"
     	bus_titulo     = "VENTANA SELECCION DE TARIFAS"
  CASE "tipoiva"
      bus_datawindow = "dw_ayuda_contaiva"
    	bus_titulo     = "VENTANA SELECCION DE Tipos de Iva"
		 bus_filtro = " ejercicio = "+String(f_ejercicio_activo(codigo_empresa))
  CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
  CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "VENTANA SELECCION BANCOS DE COBRO"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

END IF

IF Key = KeyTab! THEN
		String codcli
		IF GetRow() =0 Then Return
		AcceptText()
		codcli = GetItemString(This.GetRow(),"cliente")
		
		if Integer(codcli)=0 then Return
		
		CHOOSE CASE GetColumnName()
			
			CASE "cliente"
				String var_Nombre,var_direcc,var_codpostal,var_provincia,var_pais,var_localidad
				str_venfac ped
				Integer  var_ejercicio
				String var_empresa,var_codigo,var_tipoter
				var_ejercicio   = f_ejercicio_activo(codigo_empresa)
				IF codcli <> antecliente or IsNull(antecliente) Then
							SELECT venclientes.zona,venclientes.serie,venclientes.agente1,   
									 venclientes.agente2,venclientes.agente3,venclientes.comision1, venclientes.comision2,   venclientes.comision31,
									 venclientes.cod_pago,venclientes.dtopp,venclientes.dtoesp1,   
									 venclientes.dtoesp2, venclientes.tipoiva,
									 venclientes.forma_envio, venclientes.tipo_portes,   
									 venclientes.cod_entrega, venclientes.periodo_fac,   
									 venclientes.explicaciondto1, venclientes.explicaciondto2,   
									 venclientes.tarifa,   
									 venclientes.comision11,      venclientes.comision22,   venclientes.comision32, 
									 venclientes.dtoesp3,         venclientes.dtoesp4,   
									 venclientes.explicaciondto3, venclientes.explicaciondto4,   
									 venclientes.tipodto1,        venclientes.tipodto2,   
									 venclientes.tipodto3,        venclientes.tipodto4,   
									 venclientes.empresa,         venclientes.codigo  ,
									 venclientes.cod_entrega,     venclientes.calculo_dto  ,
									 venclientes.banco_de_cobro,  venclientes.envio,
									 venclientes.correspondencia, venclientes.domiciliacion,venclientes.transportista,
									 venclientes.agrupa,          venclientes.calculo_dtoesp,
									 venclientes.dtoesp
							INTO   :venfac.zona, :venfac.serie, :venfac.agente1, :venfac.agente2,:venfac.agente3,:venfac.comision11,   
									 :venfac.comision21,:venfac.comision31,:venfac.codpago,:venfac.dtopp,:venfac.dtoesp1,
									 :venfac.dtoesp2,:venfac.tipoiva, :venfac.forma_envio,   
									 :venfac.tipo_portes,:venfac.cod_entrega,:venfac.periodo_fac,
									 :venfac.explicaciondto1,:venfac.explicaciondto2,   
									 :venfac.tarifa,:venfac.comision12,:venfac.comision22,:venfac.comision32,:venfac.dtoesp3,   
									 :venfac.dtoesp4,:venfac.explicaciondto3,:venfac.explicaciondto4,
									 :venfac.tipodto1,:venfac.tipodto2,:venfac.tipodto3,:venfac.tipodto4,   
									 :venfac.empresa,:venfac.cliente ,:venfac.cod_entrega,
									 :venfac.calculo_dto,:venfac.banco_de_cobro,
									 :venfac.envio,:venfac.correspondencia,
									 :venfac.domiciliacion,:venfac.transportista,
									 :venfac.agrupa, :venfac.calculo_dtoesp,
							       :venfac.dtoesp
							 FROM  venclientes  
							WHERE  venclientes.empresa = :codigo_empresa 
							  AND  venclientes.codigo  = :codcli ;
							  
								// No debe coger la serie del cliente sino de lo que yo introduzca en la cabecera de factura David 30-09-04
							  venfac.serie = uo_serie.em_codigo.text
							  
						  	  IF SQLCA.SQLCODE <>0 Then f_mensaje("Error base de datos","Error datos del cliente")
								 
								 
								 
 
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",venfac.cliente)
		
					     Select  genter.empresa,genter.tipoter,genter.codigo,genter.idioma,genter.moneda
							 Into  :var_empresa,:var_tipoter,:var_codigo,:venfac.idioma,:venfac.divisa
							 From  genter
							Where  genter.empresa = :codigo_empresa 
							  And  genter.tipoter = 'C'
							  And  genter.codigo  = :codcli;
						   IF SQLCA.SQLCODE <>0 Then f_mensaje("Error base de datos","Error datos generales del cliente")
				  
							SELECT contaiva.iva  INTO :venfac.iva  
							FROM contaiva  
							WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
									( contaiva.empresa = :codigo_empresa ) AND  
									( contaiva.tipoiva = :venfac.tipoiva )   ;
							IF SQLCA.SQLCODE <>0 Then f_mensaje("Error base de datos","Error datos del cliente (iva)")
			  
							apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"codpago",venfac.codpago)
							apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"banco_de_cobro",venfac.banco_de_cobro)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",venfac.cliente)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente1",venfac.agente1)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente2",venfac.agente2)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente3",venfac.agente3)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision11",venfac.comision11)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision21",venfac.comision21)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision31",venfac.comision31)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision12",venfac.comision12)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision22",venfac.comision22)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision32",venfac.comision32)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtopp",venfac.dtopp)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp1",venfac.dtoesp1)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp2",venfac.dtoesp2)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp3",venfac.dtoesp3)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp4",venfac.dtoesp4)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto1",venfac.tipodto1)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto2",venfac.tipodto2)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto3",venfac.tipodto3)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto4",venfac.tipodto4)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto1",venfac.explicaciondto1)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto2",venfac.explicaciondto2)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto3",venfac.explicaciondto3)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto4",venfac.explicaciondto4)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dto",venfac.calculo_dto)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"envio",venfac.envio)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cod_entrega",venfac.cod_entrega)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"correspondencia",venfac.correspondencia)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"domiciliacion",venfac.domiciliacion)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"transportista",venfac.transportista)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agrupa",venfac.agrupa)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"periodo_fac",venfac.periodo_fac)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dtoesp",venfac.calculo_dtoesp)
							apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp",venfac.dtoesp)
							apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"pais",f_pais_genter(codigo_empresa,"C",venfac.cliente))
		
							SetItem(GetRow(),"tipoiva",venfac.tipoiva)
							SetItem(GetRow(),"iva",venfac.iva)	  
							SetItem(GetRow(),"serie",venfac.serie)
							SetItem(GetRow(),"zona",venfac.zona)
							SetItem(GetRow(),"forma_envio",venfac.forma_envio)
							SetItem(GetRow(),"cod_entrega",venfac.cod_entrega)
			End if
				SetItem(GetRow(),"idioma",venfac.idioma)
				SetItem(GetRow(),"divisa",venfac.divisa)
				SetItem(GetRow(),"tarifa",venfac.tarifa)
				antecliente = codcli
    	END CHOOSE
		
	End if



end event

event dw_pagina1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
   CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
   CASE "tipoiva"
      bus_datawindow = "dw_ayuda_contaiva"
    	bus_titulo     = "VENTANA SELECCION DE Tipos de Iva"
  	   bus_filtro = " ejercicio = "+String(f_ejercicio_activo(codigo_empresa))		
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
      valor_empresa = FALSE		  
  CASE "tarifa"
      bus_datawindow = "dw_ayuda_ventarifas"
     	bus_titulo     = "VENTANA SELECCION DE TARIFAS"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISA"
	   valor_empresa = FALSE
  CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "VENTANA SELECCION BANCOS DE COBRO"
  CASE "cliente"
		bus_titulo     = "VENTANA SELECCION CLIENTES"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		

  CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"

   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIRECCIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//

 f_valores_numericos(This,"divisa")
 f_valores_numericos(This,"tarifa")
 f_valores_numericos(This,"cliente")
      
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_pagina1::getfocus;IF apartados.pagina_1.dw_pagina1.GetRow()= 0 Then Return

antecliente = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),"cliente")
antedivisa  = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),"divisa")

end event

event dw_pagina1::itemchanged;call super::itemchanged;string ls_peso_bruto_maximo_lineas,ls_peso_neto_maximo_lineas
dec  ld_peso_neto_actual,ld_peso_neto_anterior,ld_peso_bruto_actual,ld_peso_bruto_anterior,ld_relacion_peso
dec  ld_peso_bruto_lineas,ld_diferencia,ld_diferencia_albaran,ld_peso_neto_lineas
long ll_anyo,ll_factura,ll_indice,ll_total,ll_donde

ll_anyo = dec(em_anyo.text)
ll_factura = dec(sle_valor.text)

choose case dwo.name
	case "peso"
		ld_peso_bruto_actual = dec(data)
		
		select isnull(peso,0)
		into   :ld_peso_bruto_anterior
		from   venfac
		where  empresa = :codigo_empresa
		and    anyo    = :ll_anyo
		and    factura = :ll_factura;
		
		if ld_peso_bruto_actual <> ld_peso_bruto_anterior then
			if ld_peso_bruto_anterior <> 0 then
				ld_relacion_peso = ld_peso_bruto_actual / ld_peso_bruto_anterior
			else
				ld_relacion_peso = 0
			end if
			ll_total = apartados.pagina_1.dw_pesos_albaranes.rowcount()
						
			for ll_indice = 1 to ll_total
				apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_indice] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_indice] * ld_relacion_peso,0)
			next
			
			ld_peso_bruto_lineas = dec(apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('sum(peso_bruto_albaran for all)',1)"))
			
			if ld_peso_bruto_lineas <> ld_peso_bruto_actual then
				//Repartimos la diferencia entre todos los albaranes
				ld_diferencia = ld_peso_bruto_lineas - ld_peso_bruto_actual
				ld_diferencia_albaran = round(ld_diferencia / ll_total,0)
				
				if ld_diferencia_albaran > 1 then
					for ll_indice = 1 to ll_total
						apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_indice] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_indice] - ld_diferencia_albaran,0)
					next		
					ld_peso_bruto_lineas = dec(apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('sum(peso_bruto_albaran for all)',1)"))
					if ld_peso_bruto_lineas <> ld_peso_bruto_actual then
						ld_diferencia = ld_peso_bruto_lineas - ld_peso_bruto_actual
						ls_peso_bruto_maximo_lineas = apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('max(peso_bruto_albaran for all)',1)")
						ll_donde = apartados.pagina_1.dw_pesos_albaranes.find("peso_bruto_albaran="+ls_peso_bruto_maximo_lineas,1,ll_total)
						if ll_donde > 0 then
							apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_donde] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_donde] - ld_diferencia,0)
						end if						
					end if
				else
					ls_peso_bruto_maximo_lineas = apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('max(peso_bruto_albaran for all)',1)")
					ll_donde = apartados.pagina_1.dw_pesos_albaranes.find("peso_bruto_albaran="+ls_peso_bruto_maximo_lineas,1,ll_total)
					if ll_donde > 0 then
						apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_donde] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_bruto_albaran[ll_donde] - ld_diferencia,0)
					end if
				end if
				
			end if
		end if
	case "peso_neto"
		ld_peso_neto_actual = dec(data)
		
		select isnull(peso_neto,0)
		into   :ld_peso_neto_anterior
		from   venfac
		where  empresa = :codigo_empresa
		and    anyo    = :ll_anyo
		and    factura = :ll_factura;		
		
		if ld_peso_neto_actual <> ld_peso_neto_anterior then
			if ld_peso_neto_anterior <> 0 then
				ld_relacion_peso = ld_peso_neto_actual / ld_peso_neto_anterior
			else
				ld_relacion_peso = 0
			end if
			ll_total = apartados.pagina_1.dw_pesos_albaranes.rowcount()
						
			for ll_indice = 1 to ll_total
				apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_indice] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_indice] * ld_relacion_peso,0)
			next
			
			ld_peso_neto_lineas = dec(apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('sum(peso_neto_albaran for all)',1)"))
			
			if ld_peso_neto_lineas <> ld_peso_neto_actual then
				//Repartimos la diferencia entre todos los albaranes
				ld_diferencia = ld_peso_neto_lineas - ld_peso_neto_actual
				ld_diferencia_albaran = round(ld_diferencia / ll_total,0)
				
				if ld_diferencia_albaran > 1 then
					for ll_indice = 1 to ll_total
						apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_indice] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_indice] - ld_diferencia_albaran,0)
					next		
					ld_peso_neto_lineas = dec(apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('sum(peso_neto_albaran for all)',1)"))
					
					if ld_peso_neto_lineas <> ld_peso_neto_actual then
						ld_diferencia = ld_peso_neto_lineas - ld_peso_neto_actual
						ls_peso_neto_maximo_lineas = apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('max(peso_neto_albaran for all)',1)")
						
						ll_donde = apartados.pagina_1.dw_pesos_albaranes.find("peso_neto_albaran="+ls_peso_neto_maximo_lineas,1,ll_total)
						if ll_donde > 0 then
							apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_donde] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_donde] - ld_diferencia,0)
						end if						
					end if
				else
					ls_peso_neto_maximo_lineas = apartados.pagina_1.dw_pesos_albaranes.describe("evaluate('max(peso_neto_albaran for all)',1)")
					ll_donde = apartados.pagina_1.dw_pesos_albaranes.find("peso_neto_albaran="+ls_peso_neto_maximo_lineas,1,ll_total)
					
					if ll_donde > 0 then
						apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_donde] = round(apartados.pagina_1.dw_pesos_albaranes.object.peso_neto_albaran[ll_donde] - ld_diferencia,0)
					end if
				end if
				
			end if
		end if
end choose
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 3593
integer height = 1548
string text = "Datos Comerciales"
end type

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 5
integer y = 4
integer width = 3584
integer height = 1540
string dataobject = "dw_int_venfac4"
boolean border = true
end type

event dw_pagina2::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_agente1'
   
	lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"agente1")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  

CASE 'pb_agente2'
	
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  
	  
CASE 'pb_agente3'
	
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente3")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  

CASE "pb_envio"
   
	lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
   OpenWithParm(wi_mant_venenvio,lstr_param)

CASE "pb_correspondencia"

   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
   OpenWithParm(wi_mant_vencorrespondencia,lstr_param)

CASE "pb_transportista"
  
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)

CASE "pb_domiciliacion"
  
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
   OpenWithParm(wi_mant_vendomiciliacion,lstr_param)

END CHOOSE



end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina2::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo


   CASE "envio"
		   bus_datawindow = "dw_ayuda_venenvio"
			bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "correspondencia"
			bus_datawindow = "dw_ayuda_vencorrespondencia"
			bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "domiciliacion"
			bus_datawindow = "dw_ayuda_vendomiciliacion"
			bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "transportista"
			bus_datawindow = "dw_ayuda_ventransportistas"
			bus_titulo = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	      bus_filtro = ""
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

 CHOOSE CASE bus_campo
     CASE "cliente"
	  This.TriggerEvent("itemchanged")
 END CHOOSE

END IF


end event

event dw_pagina2::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISAS"
   CASE "domiciliacion"
		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	   bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE "transportista"
		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo     = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	   bus_filtro     = ""
  CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE "correspondencia"
		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
	   bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina2::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(this,"agente1")
       f_valores_numericos(This,"agente2")
       f_valores_numericos(This,"agente3")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3593
integer height = 1548
string text = "T/Comercial"
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 5
integer y = 4
integer width = 3584
integer height = 1544
string dataobject = "dw_int_venfac3"
boolean border = true
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
boolean visible = false
integer width = 3593
integer height = 1548
string text = ""
end type

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 5
integer y = 128
integer width = 2811
integer height = 1024
boolean vscrollbar = true
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 3593
integer height = 1548
string text = "T/Ad/Nac"
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 0
integer y = 12
integer width = 3584
integer height = 1544
string dataobject = "dw_int_venfac6"
end type

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3593
integer height = 1548
string text = "T/Ad/Ex"
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer x = 5
integer y = 4
integer width = 3584
integer height = 1544
string dataobject = "dw_int_venfac7"
boolean border = true
end type

event dw_pagina6::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 3593
integer height = 1548
string text = "Consultar"
uo_cliente uo_cliente
st_21 st_21
end type

on pagina_7.create
this.uo_cliente=create uo_cliente
this.st_21=create st_21
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.st_21
end on

on pagina_7.destroy
call super::destroy
destroy(this.uo_cliente)
destroy(this.st_21)
end on

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer x = 5
integer y = 128
integer width = 2729
integer height = 972
string dataobject = "dw_int_venfac8"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_pagina7::doubleclicked;call super::doubleclicked;IF row=0 then Return
em_anyo.text= String(GetItemNumber(row,"anyo"))
sle_valor.text= String(GetItemNumber(row,"factura"))
apartados.getParent().TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
apartados.SelectTab(1)
end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3593
integer height = 1548
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
end type

type dw_pesos_albaranes from u_datawindow within pagina_1
integer x = 2789
integer y = 4
integer width = 800
integer height = 1540
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Datos Albaranes"
string dataobject = "dw_int_venfac9"
boolean vscrollbar = true
end type

event clicked;call super::clicked;long ll_row
string ls_objeto_y_row,ls_describe,is_contenedor,is_booking

if not(cb_insertar.enabled) then
	apartados.triggerevent("pulsar_datawindow")
end if

ls_objeto_y_row = getobjectatpointer()
ll_row = long(mid(ls_objeto_y_row, pos(ls_objeto_y_row, "~t"), 4))

if dwo.name = 'p_mostrar_datos' then
	
	//if this.object.ver_datos_extendidos[ll_row] = 'N' then
	if this.describe('p_mostrar_datos.filename') = 'C:\Bmp\up.bmp' then	
		//this.object.ver_datos_extendidos[ll_row] = 'S'
		this.modify("datawindow.detail.height = 208")
		this.modify("p_mostrar_datos.filename='C:\Bmp\down.bmp'")
	else
		//this.object.ver_datos_extendidos[ll_row] = 'N'
		this.modify("datawindow.detail.height = 716")
		this.modify("p_mostrar_datos.filename='C:\Bmp\up.bmp'")
	end if
	
	this.groupcalc()
//datawindow.detail.height = 224
end if

if dwo.name = 'b_imprimir_vgm' then
	ls_describe = this.describe("evaluate('isRowModified()',"+string(ll_row,"##0")+")")
	
	if ls_describe = 'false' then		
		is_contenedor = this.object.contenedor[ll_row]
		is_booking    = this.object.booking[ll_row]
		f_cargar_report_vgm_contenedor_booking_facturado(codigo_empresa,is_contenedor,is_booking,dw_listado_vgm)
		
		f_imprimir_datawindow(dw_listado_vgm)				
	else
		messagebox('Atención!','No se puede imprimir el VGM mientras se está editando el registro.')
	end if
end if
end event

event itemchanged;call super::itemchanged;dec ld_peso_neto_total,ld_peso_bruto_total
dec ld_peso_neto_linea,ld_peso_bruto_linea
dec ld_peso_neto_linea_nuevo,ld_peso_bruto_linea_nuevo

if not(cb_insertar.enabled) then
	apartados.triggerevent("pulsar_datawindow")
end if

choose case dwo.name
	case "peso_neto_albaran"
		ld_peso_neto_total       = dec(this.describe("evaluate('sum(peso_neto_albaran for all)',1)"))
		ld_peso_neto_linea       = this.object.peso_neto_albaran[row]
		ld_peso_neto_linea_nuevo = dec(data)
		
		ld_peso_neto_total       = ld_peso_neto_total + (ld_peso_neto_linea_nuevo - ld_peso_neto_linea)
		apartados.pagina_1.dw_pagina1.object.peso_neto[1] = ld_peso_neto_total
		
	case "peso_bruto_albaran"
		ld_peso_bruto_total       = dec(this.describe("evaluate('sum(peso_bruto_albaran for all)',1)"))
		ld_peso_bruto_linea       = this.object.peso_bruto_albaran[row]
		ld_peso_bruto_linea_nuevo = dec(data)
		
		ld_peso_bruto_total       = ld_peso_bruto_total + (ld_peso_bruto_linea_nuevo - ld_peso_bruto_linea)
		apartados.pagina_1.dw_pagina1.object.peso[1] = ld_peso_bruto_total
				
end choose
end event

type uo_cliente from u_em_campo_2 within pagina_7
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 256
integer y = 20
integer width = 1934
integer height = 88
integer taborder = 4
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_pag7.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

event getfocus;call super::getfocus;
   ue_titulo     = "AYUDA SELECCION DE CLIENTES"
	ue_datawindow = "dw_ayuda_clientes"
	ue_filtro     = ""



 
        
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type st_21 from statictext within pagina_7
integer x = 23
integer y = 32
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_int_venfac
integer x = 297
integer y = 168
integer width = 215
integer taborder = 10
end type

type pb_calculadora from u_calculadora within w_int_venfac
event clicked pbm_bnclicked
integer x = 1111
integer y = 160
integer taborder = 0
end type

event clicked;Dec     max_factura,anyo,existe
String  var_empresa,ser

anyo = Integer(em_anyo.text)
ser = uo_serie.em_codigo.text
if isnull(ser) then ser = ""

if trim(ser) <> "" and anyo > 0 and not(cb_insertar.enabled) then
	
	Select factura 
	Into   :max_factura
	From   venparamfac
	Where  venparamfac.empresa = :codigo_empresa
	And    venparamfac.anyo   = :anyo
	And    venparamfac.serie  = :ser;
			
	IF IsNUll(max_factura) Then max_factura = 0
			
	Select Count(*) 
	Into   :existe
	From   venfac
	Where  empresa = :codigo_empresa
	And    anyo    = :anyo
	And    factura = :max_factura +1 ;
			
	IF Isnull(existe) Then existe =0
	IF existe <> 0 Then
		Select max((venfac.factura))
		Into   :max_factura
		From   venfac
		Where  venfac.empresa = :codigo_empresa
		And    venfac.anyo    = :anyo
		And    venfac.serie   = :ser;
	END IF
	
	max_factura ++
	
	UPDATE venparamfac
	SET    factura = :max_factura
	Where  empresa = :codigo_empresa
	And    anyo    = :anyo
	And    serie   = :ser;
	
	IF SQLCA.SQLCODE <> 0 Then 
		rollback;
	else
		commit;
	end if
	
	sle_valor.text=String(max_factura,"############")
	apartados.TriggerEvent("pulsar_datawindow")
end if
end event

type cb_lineas from u_boton within w_int_venfac
event clicked pbm_bnclicked
integer x = 1495
integer y = 172
integer width = 306
integer height = 76
integer taborder = 0
string text = "F6 lineas"
end type

event clicked;call super::clicked;IF This.enabled = FALSE THEN RETURN
Integer anyo
Dec factura

anyo    = Integer(em_anyo.text)
factura = Dec(sle_valor.text)

Select venfac.factura  Into :factura  from venfac
where  venfac.empresa = :codigo_empresa
and    venfac.anyo    = :anyo
and    venfac.factura   = :factura ;
IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo de la factura no existe","Introduzca la factura",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF



titulo        =  Parent.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[2]   =  Trim(em_anyo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]  =  criterio[1]+criterio[2]+criterio[3]
tabla[1]      =  "venfac"
IF NOT f_bloquear(tabla[1],seleccion[1],titulo) THEN
 COMMIT;
 str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_int_venlifac,lstr_param)
 Return
END IF
 f_activar_campo(sle_valor)
end event

type dw_proceso from datawindow within w_int_venfac
boolean visible = false
integer x = 32
integer y = 24
integer width = 247
integer height = 72
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_proceso_venliproformas"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_int_venfac
integer x = 1243
integer y = 160
integer taborder = 0
end type

event clicked;call super::clicked;IF Trim(sle_valor.text) = "" THEN Return
str_parametros pa
Dec{0} anyo,factura
anyo   = Dec(em_anyo.text)
factura = Dec(sle_valor.text)
			 pa.i_nargumentos    = 5
			 pa.s_argumentos[1]=codigo_empresa
			 pa.s_argumentos[2]=String(anyo,"#######")
			 pa.s_argumentos[3]=String(factura,"##########")
			 pa.s_argumentos[4]="Si"
			 pa.s_argumentos[5]="1"

			 OpenWithParm(w_lis_venfacturas,pa)
f_activar_campo(sle_valor)
end event

type dw_report from datawindow within w_int_venfac
boolean visible = false
integer x = 5
integer width = 494
integer height = 108
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_venliped"
boolean livescroll = true
end type

type gb_1 from groupbox within w_int_venfac
integer x = 1481
integer y = 132
integer width = 1266
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_serie from u_em_campo_2 within w_int_venfac
event destroy ( )
integer x = 603
integer y = 164
integer width = 201
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text = f_nombre_venseries_abr(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type st_2 from statictext within w_int_venfac
integer x = 526
integer y = 168
integer width = 59
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado_vgm from datawindow within w_int_venfac
boolean visible = false
integer x = 3451
integer width = 178
integer height = 108
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "VGM"
string dataobject = "dw_report_vgm"
boolean livescroll = true
end type

