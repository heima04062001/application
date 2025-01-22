// src/item/dto/update-item.dto.ts
import { IsString, IsOptional, IsNumber, Min, IsBoolean } from 'class-validator';

export class UpdateItemDto {

  @IsString()
  @IsOptional()
  title?: string;  // アイテムの説明（任意）

  @IsNumber()
  @IsOptional()
  description?: string;  // アイテムの価格（任意）

  @IsBoolean()
  @IsOptional()
  status?: boolean;  // アイテムのカテゴリー（任意）
}
